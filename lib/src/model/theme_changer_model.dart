import 'package:flutter/material.dart';

class ThemeChangerModel with ChangeNotifier {
  bool _isDark = false;
  Color _backgroundColor = Colors.white;
  Color _titleColor = Colors.black;
  double _opacity = 0.4;

  bool get isDark => this._isDark;
  Color get backgroundColor => this._backgroundColor;
  Color get titleColor => this._titleColor;
  double get opacity => this._opacity;

  set isDark(bool value) {
    this._isDark = value;
    colors(_isDark);
    notifyListeners();
  }

  void colors(bool isDark) {
    if (isDark) {
      _backgroundColor = Colors.black87;
      _titleColor = Colors.white;
      _opacity = 0.7;
    } else {
      _backgroundColor = Colors.white;
      _titleColor = Colors.black;
      _opacity = 0.4;
    }
  }
}
