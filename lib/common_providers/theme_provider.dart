import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  setThemeMode(ThemeMode themeMode) {
    try {
      this.themeMode = themeMode;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
