import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeServiceProvider extends ChangeNotifier {
  bool isDarkModeOn = false;

  void toggleTheme() {
    isDarkModeOn = !isDarkModeOn;
    notifyListeners();
  }
}