import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      // Navigasi ke halaman login setelah 3 detik
      Get.offNamed('/login');
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Ganti dengan warna splash Anda
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo/logoAPP.PNG', height: 100), // Logo aplikasi
            SizedBox(height: 20),
            Text(
              'Welcome to Laundry in',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Laundry jadi kebih mudah',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
