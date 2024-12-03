// lib/controllers/laundry_controller.dart
import 'package:get/get.dart';

class LaundryController extends GetxController {
  var laundryList = <Laundry>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLaundryData();
  }

  void fetchLaundryData() {
    laundryList.value = [
      Laundry(
        title: 'Ida Laundry',
        imageUrl: 'assets/images/gambar1.png',
        rating: 4.8,
        distance: '0.20 km',
        description: 'Laundry cepat dan bersih.',
        priceList: 'Cuci Kering: Rp. 10.000\nCuci Basah: Rp. 15.000',
      ),
      // Tambahkan laundry lain jika perlu
    ];
  }
}

class Laundry {
  String title;
  String imageUrl;
  double rating;
  String distance;
  String description;
  String priceList;

  Laundry({
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.description,
    required this.priceList,
  });
}
