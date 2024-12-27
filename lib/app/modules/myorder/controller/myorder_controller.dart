import 'package:get/get.dart';

class MyOrderController extends GetxController {
  // Daftar pesanan sementara
  var orders = [
    {'item': 'Cuci Kering', 'quantity': '2', 'price': '50,000'},
    {'item': 'Cuci Setrika', 'quantity': '1', 'price': '35,000'},
    {'item': 'Paket Hemat', 'quantity': '3', 'price': '90,000'},
  ].obs;

  // Menghapus item dari pesanan
  void removeItem(int index) {
    orders.removeAt(index);
  }

  // Menghitung total biaya
  int get totalCost {
    return orders.fold(0, (sum, order) {
      return sum + int.parse(order['price']!.replaceAll(',', ''));
    });
  }
}
