import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {
  bool? _isDarkTheme = false;
  bool? get isDarkTheme => _isDarkTheme;
  bool? _isNotification = false;
  bool? get isNotification => _isNotification;

  set isDarkTheme(bool? val) {
    _isDarkTheme = val;
    notifyListeners();
  }

  set isNotification(bool? val) {
    _isNotification = val;
    notifyListeners();
  }

  Future<dynamic> changeTheme() async {
  
  }

  Future<dynamic> NotificationAcces() async {
 
  }
}
