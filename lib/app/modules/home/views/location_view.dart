import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Pengguna'),
      ),
      body: Obx(() {
        if (!locationController.isLocationPermissionGranted.value) {
          return Center(child: Text('Permission untuk mengakses lokasi ditolak.'));
        }

        if (!locationController.isLocationServiceEnabled.value) {
          return Center(child: Text('Layanan lokasi tidak aktif.'));
        }

        if (locationController.currentPosition.value?.latitude == 0.0 &&
            locationController.currentPosition.value?.longitude == 0.0) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Koordinat Lokasi: \n'
              'Latitude: ${locationController.currentPosition.value?.latitude}\n'
              'Longitude: ${locationController.currentPosition.value?.longitude}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(locationController.currentPosition.value!.latitude, locationController.currentPosition.value!.longitude),
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('user_location'),
                    position: LatLng(locationController.currentPosition.value!.latitude, locationController.currentPosition.value!.longitude),
                  ),
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: locationController.getCurrentLocation,
        child: Icon(Icons.location_on),
      ),
    );
  }
}
