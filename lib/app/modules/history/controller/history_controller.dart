import 'package:get/get.dart';

class HistoryController extends GetxController {
  // Daftar riwayat pesanan sementara
  var history = [
    {'orderId': '001', 'item': 'Cuci Kering', 'date': '2024-12-15', 'price': '50,000'},
    {'orderId': '002', 'item': 'Cuci Setrika', 'date': '2024-12-16', 'price': '35,000'},
    {'orderId': '003', 'item': 'Paket Hemat', 'date': '2024-12-17', 'price': '90,000'},
  ].obs;

  // Menghapus item dari riwayat
  void removeItem(int index) {
    history.removeAt(index);
  }
}
