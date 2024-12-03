import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  var currentLocation = ''.obs;
  var currentAddress = ''.obs; // Menyimpan nama lokasi
  var destination = 'Lat: -7.876099, Long: 112.576474'.obs;
  var destinationAddress = 'Jl. Raya Karangan No.59, Jakaan, Bonowarih, Kec. Karang Ploso, Kabupaten Malang, Jawa Timur 65152'.obs; // Nama lokasi tujuan
  double destLatitude = -7.876099;
  double destLongitude = 112.576474;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission permanently denied.');
      }

      Position position = await Geolocator.getCurrentPosition();
      currentLocation.value =
          'Lat: ${position.latitude}, Long: ${position.longitude}';
      await getAddressFromLatLng(position.latitude, position.longitude);
    } catch (e) {
      currentLocation.value = 'Error: $e';
    }
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        currentAddress.value =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    } catch (e) {
      currentAddress.value = 'Failed to get address: $e';
    }
  }

  Future<void> openGoogleMaps() async {
    try {
      final url =
          'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.value.split(',')[0].split(':')[1].trim()},${currentLocation.value.split(',')[1].split(':')[1].trim()}&destination=$destLatitude,$destLongitude&travelmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not open Google Maps';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to open Google Maps: $e');
    }
  }
}
