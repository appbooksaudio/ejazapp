import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    // Listen for connectivity changes that now emit List<ConnectivityResult>
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Updated to accept List<ConnectivityResult>
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      Get.snackbar(
        'Alert',
        'PLEASE CONNECT TO THE INTERNET',
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.wifi_off),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
