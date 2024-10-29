import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/views/login_view.dart';
import 'package:laund/app/modules/home/views/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Cek status login saat controller diinisialisasi
  }

   Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Ambil status login

    if (isLoggedIn) {
      // Jika sudah login, navigasikan ke halaman utama
      Get.off(MainView());
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        'Success',
        'Registration successful',
        backgroundColor: Colors.green,
      );

      Get.off(LoginPage()); // Navigasi ke halaman Login
    } catch (error) {
      Get.snackbar(
        'Error',
        'Registration failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan status login ke Shared Preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.snackbar(
        'Success',
        'Login successful',
        backgroundColor: Colors.green,
      );
      Get.offNamed('/main'); // Arahkan ke halaman utama
    } catch (error) {
      Get.snackbar(
        'Error',
        'Login failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    try {
      isLoading.value = true;

      await _auth.signOut(); // Logout dari Firebase

      // Hapus status login dari Shared Preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      Get.snackbar(
        'Success',
        'Logout successful',
        backgroundColor: Colors.green,
      );

      Get.off(LoginPage()); // Navigasi kembali ke halaman Login
    } catch (error) {
      Get.snackbar(
        'Error',
        'Logout failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
