import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var profileImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Pengguna';
    profileImagePath.value = prefs.getString('profileImagePath') ?? '';
  }

  void updateUserProfile(String name, String imagePath) {
    username.value = name;
    profileImagePath.value = imagePath;
    // Simpan ke SharedPreferences jika diperlukan
    saveUserData();
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username.value);
    prefs.setString('profileImagePath', profileImagePath.value);
  }
}
