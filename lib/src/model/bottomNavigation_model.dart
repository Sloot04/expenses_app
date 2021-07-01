import 'package:flutter/material.dart';

import 'package:expenses_app/src/pages/historial_page.dart';
import 'package:expenses_app/src/pages/calendar_page.dart';
import 'package:expenses_app/src/pages/saldo_page.dart';

class BottomNavigationModel with ChangeNotifier {
  List _pages = [SaldoPage(), HistorialPage(), CalendarPage()];
  int _currentIndex = 0;

  List get pages => this._pages;
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    this._currentIndex = value;
    notifyListeners();
  }
}
