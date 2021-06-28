import 'package:flutter/material.dart';

class SaldoModel with ChangeNotifier {
  double _currentSaldo = 00.00;
  late double _ingreso;
  late double _gastos;

  String _ultimoMovimientoMotivo = "";
  double _ultimoMovimientoMonto = 0.0;

  double get currentSaldo => this._currentSaldo;
  double get ingreso => this._ingreso;
  double get gastos => this._gastos;

  String get ultimoMovimientoMotivo => this._ultimoMovimientoMotivo;
  double get ultimoMovimientoMonto => this._ultimoMovimientoMonto;

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

  set ultimoMovimientoMotivo(String motivo) {
    this._ultimoMovimientoMotivo = motivo;
    notifyListeners();
  }

  set ultimoMovimientoMonto(double monto) {
    this._ultimoMovimientoMonto = monto;
    notifyListeners();
  }
}
