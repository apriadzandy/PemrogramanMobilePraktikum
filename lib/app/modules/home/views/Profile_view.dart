import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/profile_controller.dart';
import 'package:laund/app/modules/home/views/profile_settings_view.dart'; // Import halaman baru
import 'package:laund/app/modules/home/controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0, // Menghilangkan bayangan di AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: profileController.profileImageUrl.value.isNotEmpty
                        ? NetworkImage(profileController.profileImageUrl.value)
                        : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  ),
                  SizedBox(height: 16),
                  Text(
                    profileController.username.value.isNotEmpty
                        ? profileController.username.value
                        : 'User Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900], // Warna teks biru gelap
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(Icons.shopping_cart, 'Keranjang / My Order', () {
                    // Aksi ketika Keranjang/My Order ditekan
                  }),
                  _buildListTile(Icons.history, 'History', () {
                    // Aksi ketika History ditekan
                  }),
                  _buildListTile(Icons.settings, 'Setting Profile', () {
                    Get.to(ProfileSettingsView());
                  }),
                  _buildListTile(Icons.logout, 'Logout', () {
                    authController.logoutUser(); // Panggil metode logout
                  }, isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4, // Bayangan yang lebih halus
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.blue),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87, // Teks hitam lembut
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
