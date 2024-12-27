import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/myorder/controller/myorder_controller.dart';


class MyOrderView extends StatelessWidget {
  final MyOrderController myOrderController = Get.put(MyOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
        backgroundColor: Colors.orange[800],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesanan Anda',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (myOrderController.orders.isEmpty) {
                  return Center(
                    child: Text(
                      'My Order Anda Kosong',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: myOrderController.orders.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          '${myOrderController.orders[index]['item']} x${myOrderController.orders[index]['quantity']}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'Rp ${myOrderController.orders[index]['price']}',
                          style: TextStyle(fontSize: 16, color: Colors.green[700]),
                        ),
                        leading: Icon(Icons.local_laundry_service, color: Colors.orange[800]),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () {
                            myOrderController.removeItem(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            _buildTotalCost(),
            SizedBox(height: 20),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalCost() {
    return Obx(() {
      return Text(
        'Total: Rp ${myOrderController.totalCost}',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
        ),
      );
    });
  }

  Widget _buildCheckoutButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[800], // Background color
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        ),
        onPressed: () {
          // Implement checkout functionality
          Get.snackbar('Checkout', 'Pindah ke halaman pembayaran', snackPosition: SnackPosition.BOTTOM);
        },
        child: Text(
          'Lanjutkan ke Pembayaran',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
