import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laund/app/modules/home/controllers/profile_controller.dart';

class ProfileSettingsView extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    _nameController.text = profileController.username.value; // Set nama dari controller

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar Profil
              GestureDetector(
                onTap: () => _showImageSourceSelection(context),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade200,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : profileController.profileImageUrl.value.isNotEmpty
                              ? NetworkImage(profileController.profileImageUrl.value)
                              : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5, spreadRadius: 1),
                        ],
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.blueAccent, size: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Update Nama
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Tombol Update Username
              ElevatedButton(
                onPressed: () {
                  profileController.updateUsername(_nameController.text);
                  Get.snackbar('Success', 'Username updated', backgroundColor: Colors.green, colorText: Colors.white);
                },
                child: Text('Update Username'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Tombol Delete Profile Image
              ElevatedButton(
                onPressed: () {
                  profileController.deleteProfileImage();
                  _imageFile = null; // Reset image file
                  Get.snackbar('Success', 'Profile image deleted', backgroundColor: Colors.red, colorText: Colors.white);
                },
                child: Text('Delete Profile Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Choose Image Source', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildImageSourceOption(Icons.camera, 'Camera', () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  _imageFile = File(pickedFile.path);
                  profileController.updateProfileImage(_imageFile!);
                }
                Get.back(); // Close the bottom sheet
              }),
              _buildImageSourceOption(Icons.photo, 'Gallery', () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  _imageFile = File(pickedFile.path);
                  profileController.updateProfileImage(_imageFile!);
                }
                Get.back(); // Close the bottom sheet
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      onTap: onTap,
    );
  }
}
