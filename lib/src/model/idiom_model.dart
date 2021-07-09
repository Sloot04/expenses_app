import 'package:flutter/material.dart';

class IdiomModel with ChangeNotifier {
  bool _isSpanish = true;

  String _myBalance       = 'Mi saldo';
  String _income          = 'Ingresos';
  String _expenses        = 'Gastos';
  String _reason          = 'Motivo';
  String _total           = 'Importe';
  String _add             = 'Agregar';
  String _reasonIncome    = 'Motivo de su ingreso';
  String _amountIncome    = 'Monto de su ingreso';
  String _reasonExpenses  = 'Motivo de su gasto';
  String _amountExpenses  = 'Monto de su gasto';
  String _lastMovements   = 'Últimos movimientos';
  String _noLastMovements = 'No se registraron últimos movimientos';
  String _amount          = 'Monto';
  String _date            = 'Fecha';
  String _reminders       = 'Recordatorios';
  String _addReminders    = 'Agregar Recordatorio';
  String _cancel          = 'Cancelar';
  String _resume          = 'Resumen';
  String _record          = 'Historial';

  bool get isSpanish         => this._isSpanish;
  String get myBalance       => this._myBalance;
  String get income          => this._income;
  String get expenses        => this._expenses;
  String get reason          => this._reason;
  String get total           => this._total;
  String get add             => this._add;
  String get reasonIncome    => this._reasonIncome;
  String get amountIncome    => this._amountIncome;
  String get reasonExpenses  => this._reasonExpenses;
  String get amountExpenses  => this._amountExpenses;
  String get lastMovements   => this._lastMovements;
  String get noLastMovements => this._noLastMovements;
  String get amount          => this._amount;
  String get date            => this._date;
  String get reminders       => this._reminders;
  String get addReminders    => this._addReminders;
  String get cancel          => this._cancel;
  String get resume          => this._resume;
  String get record          => this._record;

  set isSpanish(bool value) {
    this._isSpanish = value;
    idiom(_isSpanish);
    notifyListeners();
  }

  void idiom(bool isSpanish) {
    if (isSpanish) {
      _myBalance       = 'Mi saldo';
      _income          = 'Ingresos';
      _expenses        = 'Gastos';
      _reason          = 'Motivo';
      _total           = 'Importe';
      _add             = 'Agregar';
      _reasonIncome    = 'Motivo de su ingreso';
      _amountIncome    = 'Monto de su ingreso';
      _reasonExpenses  = 'Motivo de su gasto';
      _amountExpenses  = 'Monto de su gasto';
      _lastMovements   = 'Últimos movimientos';
      _noLastMovements = 'No se registraron últimos movimientos';
      _amount          = 'Monto';
      _date            = 'Fecha';
      _reminders       = 'Recordatorios';
      _addReminders    = 'Agregar Recordatorio';
      _cancel          = 'Cancelar';
      _resume          = 'Resumen';
      _record          = 'Historial';
    } else {
      _myBalance       = 'My balance';
      _income          = 'Income';
      _expenses        = 'Expenses';
      _reason          = 'Reason';
      _total           = 'Total';
      _add             = 'Add';
      _reasonIncome    = 'Reason for your income';
      _amountIncome    = 'Amount of your income';
      _reasonExpenses  = 'Reason for your expenses';
      _amountExpenses  = 'Amount of your expenses';
      _lastMovements   = 'Last movements';
      _noLastMovements = 'No last movements were registered';
      _amount          = 'Amount';
      _date            = 'Date';
      _reminders       = 'Reminders';
      _addReminders    = 'Add Reminder';
      _cancel          = 'Cancel';
      _resume          = 'Resume';
      _record          = 'Record';
    }
  }
}
