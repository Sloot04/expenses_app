import 'package:flutter/material.dart';

import 'package:expenses_app/src/pages/historial_page.dart';
import 'package:expenses_app/src/pages/resumen_page.dart';
import 'package:expenses_app/src/pages/newresume_page.dart';

class BottomNavigationModel with ChangeNotifier {
  List _pages = [NewResumePage(), HistorialPage(), Resumen()];
  int _currentIndex = 0;

  List get pages => this._pages;
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    this._currentIndex = value;
    notifyListeners();
  }
}
