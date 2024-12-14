import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/views/main_view.dart';

class NoConnectionPopup extends StatelessWidget {
  const NoConnectionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.wifi_off,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(width: 10),
          Text(
            "No Internet Connection",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "Koneksi kamu terputus nih, cek coneksi kamu ya",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      actions: [
        // Close Button
        TextButton(
          onPressed: () {
            Get.back();  // Menutup pop-up
          },
          child: const Text(
            "Close",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Try Again Button
        ElevatedButton(
          onPressed: () async {
            // Cek kembali koneksi dan arahkan ke MainView jika terhubung
            ConnectivityResult result = (await Connectivity().checkConnectivity()) as ConnectivityResult;
            if (result != ConnectivityResult.none) {
              Get.offAll(() => MainView());
            } else {
              Get.snackbar(
                "Connection Error", 
                "Please check your connection", 
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,  // Warna teks tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Try Again",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
