import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/connection/views/no_connection_view.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      _updateConnectionStatus(connectivityResults.first);
    });
  }

  // Fungsi untuk mengupdate status koneksi
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      _showNoConnectionDialog();
    } else {
      // Jika sudah terhubung kembali, tutup pop-up
      if (Get.isDialogOpen == true) {
        Get.back(); // Menutup pop-up
      }
    }
  }

  // Menampilkan dialog pop-up jika tidak ada koneksi
  void _showNoConnectionDialog() {
    if (Get.isDialogOpen == false) {
      Get.dialog(const NoConnectionPopup());  // Menampilkan pop-up
    }
  }
}
