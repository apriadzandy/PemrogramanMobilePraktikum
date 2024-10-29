import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/webview_controllers.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewPage extends StatelessWidget {
  WebviewPage({Key? key}) : super(key: key);

  // Buat instance WebviewController menggunakan GetX
  final WebviewController webviewController = Get.put(WebviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Webview"),
      ),
      body: GetBuilder<WebviewController>(
        builder: (controller) {
          return WebViewWidget(controller: controller.webViewController);
        },
      ),
    );
  }
}
