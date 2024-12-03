import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  RxBool isLocationServiceEnabled = false.obs;
  RxBool isLocationPermissionGranted = false.obs;
  Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.deniedForever) {
      isLocationPermissionGranted.value = false;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      isLocationPermissionGranted.value = permission == LocationPermission.whileInUse || permission == LocationPermission.always;
    } else {
      isLocationPermissionGranted.value = true;
    }

    isLocationServiceEnabled.value = await Geolocator.isLocationServiceEnabled();
  }

  Future<void> getCurrentLocation() async {
    if (isLocationPermissionGranted.value && isLocationServiceEnabled.value) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        currentPosition.value = position;
      } catch (e) {
        print("Error getting location: $e");
        currentPosition.value = null; // Menangani error jika gagal mengambil lokasi
      }
    } else {
      print("Lokasi tidak diizinkan atau layanan lokasi tidak aktif.");
      currentPosition.value = null; // Menangani ketika lokasi tidak diizinkan atau layanan tidak aktif
    }
  }
}
