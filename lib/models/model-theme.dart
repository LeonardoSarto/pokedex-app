import 'package:flutter/material.dart';
import 'mytheme_preference.dart';

class ModelTheme extends ChangeNotifier {
  late MyThemePreferences _preferences;
  late bool _isDark;
  late bool _isSystem;
  bool get isDark => _isDark;
  bool get isSystem => _isSystem;

  ModelTheme() {
    _isDark = false;
    _isSystem = true;
    _preferences = MyThemePreferences();
    getPreferences();
  }

  set isDark(bool value) {
    _isSystem = false;
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  set isSystem(bool value) {
    _isDark = false;
    _isSystem = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}