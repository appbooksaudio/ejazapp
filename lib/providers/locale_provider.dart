import 'package:chat_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleProvider with ChangeNotifier {
  Locale? localelang;
  Locale? get locale => localelang;
  set locale(Locale? val) {
    localelang = val;
    notifyListeners();
  }

  void setLocale(Locale? locale) async {
    if (!L10n.all.contains(locale)) return;
    localelang = locale;
    notifyListeners();
  }

  void clearLocale() {
    localelang = null;
    notifyListeners();
  }

  initState() {
   
  }
}
