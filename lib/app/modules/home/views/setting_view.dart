import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Setting_controller.dart';

class SettingView extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set nilai awal username ke dalam controller saat inisialisasi
    nameController.text = controller.username.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Profile'),
        backgroundColor: Colors.blueAccent, // Warna biru yang lebih cerah untuk AppBar
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return CircleAvatar(
                  radius: 60,
                  backgroundImage: controller.profileImagePath.value.isNotEmpty
                      ? FileImage(File(controller.profileImagePath.value))
                      : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                );
              }),
              SizedBox(height: 20),

              // Tombol untuk Edit Foto Profil
              ElevatedButton.icon(
                onPressed: () {
                  _showImageSourceDialog(context);
                },
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text('Edit Foto Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  controller.resetProfileImage(); // Panggil fungsi hapus foto profil
                },
                icon: Icon(Icons.delete, color: Colors.white),
                label: Text('Hapus Foto Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
              SizedBox(height: 20),

              // TextField untuk Nama Pengguna dengan tombol centang
              Obx(() {
                if (nameController.text != controller.username.value) {
                  nameController.text = controller.username.value;
                  nameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: nameController.text.length), // Menjaga posisi kursor
                  );
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            labelText: 'Nama Pengguna',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            hintText: 'Masukkan nama Anda',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            controller.updateUsername(value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          // Simpan nama setelah selesai mengetik
                          controller.updateUsername(nameController.text);
                        },
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pemilihan sumber gambar
  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 160,
          child: Column(
            children: [
              Text('Pilih Sumber Gambar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.pickImage();
                      Navigator.pop(context); // Menutup dialog setelah memilih gambar
                    },
                    icon: Icon(Icons.image, color: Colors.white),
                    label: Text('Galeri'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.pickImageFromCamera();
                      Navigator.pop(context); // Menutup dialog setelah memilih kamera
                    },
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    label: Text('Kamera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
