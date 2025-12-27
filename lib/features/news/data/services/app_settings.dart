import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  bool _darkMode = false;
  double _fontScale = 1.0;

  bool get darkMode => _darkMode;
  double get fontScale => _fontScale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    _fontScale = prefs.getDouble('fontScale') ?? 1.0;
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _darkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    notifyListeners();
  }

  Future<void> updateFont(double value) async {
    _fontScale = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontScale', value);
    notifyListeners();
  }
}
