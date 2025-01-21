import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../core/services/services.dart';

class ChatController extends GetxController {
  late HubConnection hubConnection;
  MyServices myServices = Get.find();
  List<String> sampleList = <String>[].obs;

  void initHubConnection() {

    String? userName = 'ejazbackend';
    String? token = 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImVqYXpiYWNrZW5kIiwibmFtZWlkIjoiMTEyOTQ0MDkzNTM2NTE3Mjc3MTQ0IiwiZW1haWwiOiJlamF6YmFja2VuZEBnbWFpbC5jb20iLCJuYmYiOjE3MzcyODk2NTYsImV4cCI6MTczNzI5MTQ1NiwiaWF0IjoxNzM3Mjg5NjU2fQ.j3ZF6TGJawuufhz66bT4oBSEK1DW7FwH50LLr5zeVbeJlbyuYCoGGBjZftcILUH_rmcWbWoArU3mqLPQjV03e';

    hubConnection = HubConnectionBuilder()
        .withUrl(
            'http://localhost:5000/chathub?u=${userName}&access_token=${token}')
        .build();
  }
  
}
