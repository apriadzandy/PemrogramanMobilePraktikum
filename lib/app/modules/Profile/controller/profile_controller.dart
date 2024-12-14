import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  RxString username = ''.obs;
  RxString profileImageUrl = ''.obs;
  RxBool isConnected = false.obs; // Monitoring koneksi

  final _localStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkConnection();
    _listenToConnection();
    loadUserProfile(); // Muat profil pengguna saat controller diinisialisasi
  }

  // Mengecek koneksi saat aplikasi dimulai
  void _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = (connectivityResult != ConnectivityResult.none);
  }

  // Memantau perubahan status koneksi
  void _listenToConnection() {
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      isConnected.value = (connectivityResult != ConnectivityResult.none);
      if (isConnected.value) {
        _retryPendingUpdates(); // Coba upload data pending jika online
      }
    });
  }

  Future<void> loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        username.value = userDoc['username'] ?? 'User Name';
        profileImageUrl.value = userDoc['profileImageUrl'] ?? '';
      }
    }
  }

  Future<void> updateUsername(String newUsername) async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (isConnected.value) {
        try {
          await _firestore.collection('users').doc(user.uid).update({
            'username': newUsername,
          });
          username.value = newUsername;
          _localStorage.remove('pendingUsername'); // Hapus data lokal
          Get.snackbar('Success', 'Username updated successfully');
        } catch (e) {
          Get.snackbar('Error', 'Failed to update username: $e');
        }
      } else {
        // Simpan ke penyimpanan lokal jika offline
        _localStorage.write('pendingUsername', newUsername);
        username.value = newUsername;
        Get.snackbar('Offline', 'Username saved locally, will update later');
      }
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String filePath = 'profile_images/${user.uid}.png';

      if (isConnected.value) {
        try {
          // Upload gambar ke Firebase Storage
          await _storage.ref(filePath).putFile(imageFile);

          // Ambil URL gambar yang baru di-upload
          String downloadUrl = await _storage.ref(filePath).getDownloadURL();

          // Update URL gambar profil di Firestore
          await _firestore.collection('users').doc(user.uid).update({
            'profileImageUrl': downloadUrl,
          });
          profileImageUrl.value = downloadUrl;
          _localStorage.remove('pendingProfileImage'); // Hapus data lokal
          Get.snackbar('Success', 'Profile image updated successfully');
        } catch (e) {
          Get.snackbar('Error', 'Failed to upload image: $e');
        }
      } else {
        // Simpan path gambar ke penyimpanan lokal jika offline
        _localStorage.write('pendingProfileImage', imageFile.path);
        profileImageUrl.value = imageFile.path; // Update sementara
        Get.snackbar('Offline', 'Image saved locally, will upload later');
      }
    }
  }

    Future<void> deleteProfileImage() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String filePath = 'profile_images/${user.uid}.png';

      if (isConnected.value) {
        try {
          // Hapus gambar dari Firebase Storage
          await _storage.ref(filePath).delete();

          // Hapus URL gambar profil di Firestore
          await _firestore.collection('users').doc(user.uid).update({
            'profileImageUrl': '',
          });

          profileImageUrl.value = ''; // Setel ulang URL gambar profil
          _localStorage.remove('pendingDeleteProfileImage'); // Hapus status lokal
          Get.snackbar('Success', 'Profile image deleted successfully');
        } catch (e) {
          Get.snackbar('Error', 'Failed to delete profile image: $e');
        }
      } else {
        // Simpan status penghapusan ke penyimpanan lokal jika offline
        _localStorage.write('pendingDeleteProfileImage', true);
        profileImageUrl.value = ''; // Setel ulang sementara
        Get.snackbar('Offline', 'Deletion saved locally, will process later');
      }
    }
  }

  Future<void> _retryPendingUpdates() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Retry pembaruan username
      String? pendingUsername = _localStorage.read('pendingUsername');
      if (pendingUsername != null) {
        await updateUsername(pendingUsername);
      }

      // Retry upload gambar
      String? pendingProfileImage = _localStorage.read('pendingProfileImage');
      if (pendingProfileImage != null) {
        File imageFile = File(pendingProfileImage);
        await updateProfileImage(imageFile);
      }

      // Retry penghapusan gambar
      bool? pendingDelete = _localStorage.read('pendingDeleteProfileImage');
      if (pendingDelete == true) {
        await deleteProfileImage();
      }
    }
  }
}
