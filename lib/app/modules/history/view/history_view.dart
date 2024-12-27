import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/history/controller/history_controller.dart';


class HistoryView extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Pesanan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (historyController.history.isEmpty) {
                  return Center(
                    child: Text(
                      'Riwayat Anda Kosong',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: historyController.history.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          '${historyController.history[index]['item']}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'Tanggal: ${historyController.history[index]['date']} - Rp ${historyController.history[index]['price']}',
                          style: TextStyle(fontSize: 16, color: Colors.green[700]),
                        ),
                        leading: Icon(Icons.history, color: Colors.blueAccent),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () {
                            historyController.removeItem(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
