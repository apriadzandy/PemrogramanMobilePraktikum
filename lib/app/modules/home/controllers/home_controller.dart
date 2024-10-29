import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var username = ''.obs; 
  var laundryList = <Laundry>[].obs; // Daftar laundry yang akan ditampilkan

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadLaundryData(); // Memuat data laundry saat controller diinisialisasi
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Pengguna'; // Default 'Pengguna'
  }

  Future<void> loadLaundryData() async {
    // Simulasi pemuatan data laundry
    laundryList.addAll([
      Laundry(title: 'Ida Laundry', imageUrl: 'assets/images/gambar1.png', rating: 4.8, distance: '0.5 km'),
      Laundry(title: 'Budi Laundry', imageUrl: 'assets/images/gambar2.jpeg', rating: 4.5, distance: '1.2 km'),
      // Tambahkan laundry lainnya sesuai kebutuhan
    ]);
  }
}

class Laundry {
  final String title;
  final String imageUrl;
  final double rating;
  final String distance;

  Laundry({required this.title, required this.imageUrl, required this.rating, required this.distance});
}
