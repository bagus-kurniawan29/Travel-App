import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('id');

  Locale get currentLocale => _currentLocale;

  void changeLanguage(String type) {
    _currentLocale = Locale(type);
    notifyListeners();
  }
}
