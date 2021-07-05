import 'package:flutter/material.dart';

class ThemeChangerModel with ChangeNotifier {
  bool _isDark = false;


  bool get isDark => this._isDark;

  set isDark(bool value) {
    this._isDark = value;
  
    notifyListeners();
  }
}
