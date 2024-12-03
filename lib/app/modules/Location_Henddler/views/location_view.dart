import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/Location_Henddler/controller/location_controller.dart';

class LocationView extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Detail Lokasi Laundry',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Lokasi',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildLocationInfoRow(
                    icon: Icons.location_on,
                    title: 'Alamat Anda Saat Ini',
                    value: locationController.currentAddress.value,
                  ),
                  const SizedBox(height: 10),
                  _buildLocationInfoRow(
                    icon: Icons.my_location,
                    title: 'Koordinat Lokasi Anda',
                    value: locationController.currentLocation.value,
                  ),
                  const Divider(height: 30, thickness: 1),
                  _buildLocationInfoRow(
                    icon: Icons.store,
                    title: 'Alamat Laundry',
                    value: locationController.destinationAddress.value,
                  ),
                  const SizedBox(height: 10),
                  _buildLocationInfoRow(
                    icon: Icons.location_city,
                    title: 'Koordinat Laundry',
                    value: locationController.destination.value,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        locationController.openGoogleMaps();
                      },
                      icon: Icon(Icons.map_outlined, color: Colors.black,),
                      label: Text('Buka Dari Google Maps',
                      style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue[800], size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}