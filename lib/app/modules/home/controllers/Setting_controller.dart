import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laund/app/modules/home/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  var username = ''.obs;
  var profileImagePath = ''.obs; // Menyimpan path gambar profil
  final ImagePicker _picker = ImagePicker(); // Menjadikan picker sebagai variabel kelas

  @override
  void onInit() {
    super.onInit();
    loadUserData(); // Load data saat controller diinisialisasi
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    profileImagePath.value = prefs.getString('profileImagePath') ?? '';
  }

  Future<void> updateUsername(String value) async {
    username.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', value);
  }

  Future<void> updateProfileImage(String imagePath) async {
    profileImagePath.value = imagePath;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImagePath', imagePath);
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await updateProfileImage(image.path);
      } else {
        Get.snackbar('Error', 'No image selected'); // Handle jika pengguna batal memilih gambar
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e'); // Menangani error jika terjadi
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        await updateProfileImage(image.path);
      } else {
        Get.snackbar('Error', 'No image captured'); // Handle jika pengguna batal mengambil gambar
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture image: $e'); // Menangani error jika terjadi
    }
  }

  Future<void> resetProfileImage() async {
    profileImagePath.value = ''; // Mengatur ulang path gambar profil
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('profileImagePath'); // Menghapus path gambar dari SharedPreferences
  }
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Menghapus data pengguna dari SharedPreferences
    await prefs.remove('username');
    await prefs.remove('profileImagePath');
    
    // Mengarahkan ke halaman login setelah logout
    Get.offAll(LoginPage()); // Mengarahkan ke halaman Login
  }
}
