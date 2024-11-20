import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/laundry_detail_controller.dart';

class LaundryDetailView extends StatelessWidget {
  final LaundryDetailController controller = Get.put(LaundryDetailController());

  @override
  Widget build(BuildContext context) {
    // Mengambil data laundry dari argumen, misalnya:
    final String title = Get.arguments['title'];
    final String distance = Get.arguments['distance'];
    final double rating = Get.arguments['rating'];
    final String imageUrl = Get.arguments['imageUrl'];

    return Scaffold(
      appBar: AppBar(title: Text('Detail Laundry')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar laundry
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Info laundry
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    distance,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Rating: $rating',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // Baris deskripsi, harga, penilaian
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectInfo('deskripsi');
                        },
                        child: Text(
                          'Deskripsi',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectInfo('daftar harga');
                        },
                        child: Text(
                          'Daftar Harga',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectInfo('penilaian');
                        },
                        child: Text(
                          'Penilaian',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Menampilkan informasi berdasarkan pilihan
                  Obx(() {
                    switch (controller.selectedInfo.value) {
                      case 'deskripsi':
                        return Text('Isi deskripsi lengkap...');
                      case 'daftar harga':
                        return Text('Detail harga lengkap...');
                      case 'penilaian':
                        return Text('Isi penilaian lengkap...');
                      default:
                        return Container(); // Kosong jika tidak ada yang dipilih
                    }
                  }),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol "Pilih Laundry" tetap di bagian bawah
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            print('Laundry dipilih!');
          },
          child: Text('Pilih Laundry'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ), // Warna biru untuk tombol
          ),
        ),
      ),
    );
  }
}
