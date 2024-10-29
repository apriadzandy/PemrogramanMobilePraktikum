import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/auth_controller.dart';
import 'package:laund/app/modules/home/controllers/profile_controller.dart';
import 'package:laund/app/modules/home/views/setting_view.dart';
import 'package:laund/app/modules/home/controllers/Setting_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar dan Nama Pengguna
            Obx(() {
              return Column(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: settingController.profileImagePath.value.isNotEmpty
                          ? FileImage(File(settingController.profileImagePath.value)) // Menggunakan FileImage untuk gambar lokal
                          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    );
                  }),
                  SizedBox(height: 16),
                  Text(
                    settingController.username.value.isNotEmpty
                        ? settingController.username.value
                        : 'User Name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            // Menu Keranjang/My Order
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Keranjang / My Order'),
              onTap: () {
                // Aksi ketika Keranjang/My Order ditekan
              },
            ),
            // Menu History
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                // Aksi ketika History ditekan
              },
            ),
            // Menu Setting Profile
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting Profile'),
              onTap: () {
                Get.to(() => SettingView());
              },
            ),
             ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                final AuthController authController = Get.find();
                authController.logoutUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}

