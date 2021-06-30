import 'package:flutter/material.dart';

class MovimientosModel with ChangeNotifier {
  List<Movement> _listaMovimientos = [];

  get listaMovimientos => this._listaMovimientos;

  void addMov(Movement value) {
    listaMovimientos.add(value);
    notifyListeners();
  }

  double get saldo {
    return _listaMovimientos.fold(
        0, (previousValue, element) => previousValue + element.monto);
  }
}

class Movement {
  String motivo;
  double monto;

  Movement({required this.motivo, required this.monto}) {
    this.motivo = motivo;
    this.monto = monto;
  }

  @override
  String toString() {
    return '{ ${this.motivo}, ${this.monto} }';
  }
}
