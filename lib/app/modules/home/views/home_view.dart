import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/views/Laundry_detail_view.dart';
import 'package:laund/app/modules/home/views/weather_view.dart'; // Ganti dengan path WebView yang sesuai
import 'package:laund/app/modules/home/views/webview_page.dart';
import 'package:laund/app/modules/home/widgets/laundry_card.dart';
import 'package:laund/app/modules/home/widgets/search_widget.dart';
import 'package:laund/app/modules/home/controllers/home_controller.dart';
import 'package:laund/app/modules/home/controllers/Setting_controller.dart'; // Impor SettingController

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final SettingController settingController = Get.find(); // Ambil instance SettingController yang sudah ada
  final TextEditingController searchController = TextEditingController();
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];  // Contoh data
  List<String> filteredItems = [];

  @override
  Widget build(BuildContext context) {
    // Awalnya, semua item ditampilkan
    filteredItems = items;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Obx(() {
              // Menampilkan nama yang disimpan di SettingController secara reaktif
              return Text(
                settingController.username.value.isNotEmpty 
                    ? settingController.username.value
                    : 'Pengguna', // Jika nama belum diisi, tampilkan 'Pengguna'
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              );
            }),
          ],
        ),
        actions: [
          // Tombol WebView
          IconButton(
            icon: Icon(Icons.language), // Ikon untuk WebView
            onPressed: () {
              Get.to(WebviewPage()); // Navigasi ke halaman WebView
            },
          ),
          // Tombol cuaca
          IconButton(
            icon: Icon(Icons.water), 
            onPressed: () {
              Get.to(WeatherView()); // Navigasi ke halaman weather
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Search Bar
          SearchWidget(
            searchController: searchController,
            onSearch: (query) {
              filteredItems = items
                  .where((item) => item.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            },
          ),
          // Laundry Cards
          LaundryCard(
            title: 'Ida Laundry',
            imageUrl: 'assets/images/gambar1.png', // Gambar dari assets
            rating: 4.8,
            distance: '0.5 km',
            onTap: () {
              Get.to(LaundryDetailView(), arguments: {
                'title': 'Ida Laundry',
                'distance': '0.5 km',
                'rating': 4.8,
                'imageUrl': 'assets/images/gambar1.png',
              });
            },
          ),
          LaundryCard(
            title: 'Budi Laundry',
            imageUrl: 'assets/images/gambar2.jpeg', // Gambar dari assets
            rating: 4.5,
            distance: '1.2 km',
            onTap: () {
              Get.to(LaundryDetailView(), arguments: {
                'title': 'Budi Laundry',
                'distance': '1.2 km',
                'rating': 4.5,
                'imageUrl': 'assets/images/gambar1.png',
              });
            },
          ),
        ],
      ),
    );
  }
}
