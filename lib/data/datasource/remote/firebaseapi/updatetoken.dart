import 'dart:convert';

import 'package:ejazapp/connectapi/linkapi.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

 UpdateFirebaseToken(String token) async {
  late SharedPreferences sharedPreferences;
  sharedPreferences = await SharedPreferences.getInstance();
  String? authorized =await sharedPreferences.getString("authorized");
  Map<String, String> data = {"FirebaseToken": token};

  int contentlength = utf8.encode(json.encode(data)).length;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Content-Length': '$contentlength',
    // 'Host': '0',
    'Authorization': 'Bearer $authorized'
  };
  final msg = jsonEncode(data);
  final url = Uri.parse(
    AppLink.updatetoken,
  );
  final response = await http.put(
    url,
    headers: requestHeaders,
    body: msg,
  ); //,headers: requestHeaders,

  if (response.statusCode == 200) {
    print('token updeted');
  } else {
    print('response for update token ${response.body}  token not updated');
    // await BooksApi().SendEmailException(response.body, ApiName);
    //throw Exception();
  }
}
