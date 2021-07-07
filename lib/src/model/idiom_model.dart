import 'package:flutter/material.dart';

class IdiomModel with ChangeNotifier {
  bool _isSpanish = true;

  String _myBalance = 'Mi saldo';
  String _income = 'Ingresos';
  String _expenses = 'Gastos';
  String _reason = 'Motivo';
  String _total = 'Importe';
  String _add = 'Agregar';
  String _reasonIncome = 'Motivo de su ingreso';
  String _amountIncome = 'Monto de su ingreso';
  String _reasonExpenses = 'Motivo de su gasto';
  String _amountExpenses = 'Monto de su gasto';
  String _lastMovements = 'Últimos movimientos';

  bool get isSpanish => this._isSpanish;
  String get myBalance => this._myBalance;
  String get income => this._income;
  String get expenses => this._expenses;
  String get reason => this._reason;
  String get total => this._total;
  String get add => this._add;
  String get reasonIncome => this._reasonIncome;
  String get amountIncome => this._amountIncome;
  String get reasonExpenses => this._reasonExpenses;
  String get amountExpenses => this._amountExpenses;
  String get lastMovements => this._lastMovements;

  set isSpanish(bool value) {
    this._isSpanish = value;
    idiom(_isSpanish);
    notifyListeners();
  }

  void idiom(bool isSpanish) {
    if (isSpanish) {
      _myBalance = 'Mi saldo';
      _income = 'Ingresos';
      _expenses = 'Gastos';
      _reason = 'Motivo';
      _total = 'Importe';
      _add = 'Agregar';
      _reasonIncome = 'Motivo de su ingreso';
      _amountIncome = 'Monto de su ingreso';
      _reasonExpenses = 'Motivo de su gasto';
      _amountExpenses = 'Monto de su gasto';
      _lastMovements = 'Últimos movimientos';
    } else {
      _myBalance = 'My balance';
      _income = 'Income';
      _expenses = 'Expenses';
      _reason = 'Reason';
      _total = 'Total';
      _add = 'Add';
      _reasonIncome = 'Reason for your income';
      _amountIncome = 'Amount of your income';
      _reasonExpenses = 'Reason for your expenses';
      _amountExpenses = 'Amount of your expenses';
      _lastMovements = 'Last movements';
    }
  }
}
