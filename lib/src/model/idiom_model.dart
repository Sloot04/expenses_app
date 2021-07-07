import 'package:flutter/material.dart';

class IdiomModel with ChangeNotifier {
  bool _isSpanish = true;

  bool get isSpanish => this._isSpanish;

  set isSpanish(bool value) {
    this._isSpanish = value;
    idiom(_isSpanish);
    notifyListeners();
  }

  void idiom(bool isSpanish) {
    if (isSpanish) {
    } else {}
  }
}
