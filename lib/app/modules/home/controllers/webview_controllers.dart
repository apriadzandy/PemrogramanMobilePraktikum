import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Bisa tambahkan logika untuk progress loading jika diperlukan
          },
          onPageStarted: (String url) {
            // Aksi saat halaman mulai dimuat
          },
          onPageFinished: (String url) {
            // Aksi saat halaman selesai dimuat
          },
          onWebResourceError: (WebResourceError error) {
            
          },
          onNavigationRequest: (NavigationRequest request) {
            
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.goodlaundry.id/14-tips-mencegah-pakaian-hilang-di-tempat-laundry-anak-kost-wajib-tahu/'));
  }
}
