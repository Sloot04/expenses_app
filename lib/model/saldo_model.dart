import 'package:flutter/material.dart';

class SaldoModel with ChangeNotifier {
  double _currentSaldo = 00.00;
  late double _ingreso;
  late double _gastos;

  double get currentSaldo => this._currentSaldo;
  double get ingreso => this._ingreso;
  double get gastos => this._gastos;

  // valor = ingreso o gasto
  set currentSaldo(double valor) {
    this._currentSaldo = valor;
    notifyListeners();
  }

  set ingreso(double valor) {
    this._ingreso = valor;
    notifyListeners();
  }

  set gastos(double valor) {
    this._gastos = valor;
    notifyListeners();
  }
}
