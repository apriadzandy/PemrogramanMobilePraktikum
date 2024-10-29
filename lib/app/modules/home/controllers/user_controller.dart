import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  // Inisialisasi Firebase Auth dan Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observasi data pengguna
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Panggil saat controller diinisialisasi
  }

  // Fungsi untuk mengambil data pengguna dari Firestore
  Future<void> fetchUserData() async {
    try {
      // Mendapatkan UID pengguna yang sedang login
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Mengambil data dari Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          // Memperbarui userData dengan data yang diambil dari Firestore
          userData.assignAll(userDoc.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print('Gagal mengambil data pengguna: $e');
    }
  }

  // Fungsi untuk menyimpan atau memperbarui data pengguna di Firestore
  Future<void> updateUserData(Map<String, dynamic> newUserData) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Menyimpan data baru ke Firestore
        await _firestore.collection('users').doc(currentUser.uid).update(newUserData);
        userData.assignAll(newUserData); // Perbarui userData dengan data baru
      }
    } catch (e) {
      print('Gagal memperbarui data pengguna: $e');
    }
  }
}
