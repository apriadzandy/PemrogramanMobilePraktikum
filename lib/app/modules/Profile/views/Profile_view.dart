import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/Profile/controller/profile_controller.dart';
import 'package:laund/app/modules/Login_Register/controller/auth_controller.dart';
import 'package:laund/app/modules/Profile/views/profile_settings_view.dart';
import 'package:laund/app/modules/history/view/history_view.dart';
import 'package:laund/app/modules/home/views/sound_setting_view.dart';
import 'package:laund/app/modules/myorder/view/myorder_view.dart'; // Import SoundSettingView

class ProfileView extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
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
                      color: Colors.blue[900],
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
                    Get.to(MyOrderView());
                  }),
                  _buildListTile(Icons.history, 'History', () {
                    Get.to(HistoryView());
                  }),

                  _buildListTile(Icons.settings, 'Setting Profile', () {
                    Get.to(ProfileSettingsView());
                  }),
                  _buildListTile(Icons.volume_up, 'Sound Settings', () {
                    Get.to(SoundSettingView()); // Navigate to Sound Setting View
                  }),
                  _buildListTile(Icons.logout, 'Logout', () {
                    authController.logoutUser(); // Logout
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.blue),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        onTap: onTap,
      ),
    );
  }
}