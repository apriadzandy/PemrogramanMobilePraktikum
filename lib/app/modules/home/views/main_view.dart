// lib/views/main_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/Chat/views/chat_list_view.dart';
import 'package:laund/app/modules/home/controllers/main_controller.dart';
import 'package:laund/app/modules/home/views/home_view.dart';
import 'package:laund/app/modules/profile/views/profile_view.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());  // Inject MainController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Mengatur tampilan berdasarkan index yang dipilih
        switch (controller.selectedIndex.value) {
          case 0:
            return ChatListView();  // Halaman Chat
          case 1:
            return HomeView();  // Halaman Home (default)
          case 2:
            return ProfileView();  // Halaman Profile
          default:
            return HomeView();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTabIndex,  // Panggil fungsi untuk mengubah index
        selectedItemColor: Colors.blue,    // Warna ikon yang terpilih menjadi biru
        unselectedItemColor: Colors.grey,  // Warna ikon yang tidak terpilih menjadi abu-abu
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
