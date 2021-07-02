import 'package:expenses_app/src/widgets/title_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:expenses_app/src/model/movimiento_model.dart';
import 'package:expenses_app/src/widgets/formCustom.dart';

class SaldoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentsaldo = Provider.of<MovimientosModel>(context).saldo;
    final textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w300);

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              TitleCustom(
                title: 'Mi saldo',
                icon: FontAwesomeIcons.piggyBank,
                underline: 180.0,
                animated: false,
              ),
              Text(
                "\$${currentsaldo.toStringAsFixed(2)}",
                style: TextStyle(
                    color: currentsaldo >= 0 ? Colors.green : Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.0),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text('Ingresos', style: textStyle),
                    ),
                    FormCustom(
                      color: Colors.green,
                      esIngreso: true,
                      hintTextMotivo: "Motivo de su ingreso",
                      hintTextImporte: "Monto de su ingreso",
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text('Gastos', style: textStyle),
                    ),
                    FormCustom(
                      esIngreso: false,
                      color: Colors.red,
                      hintTextMotivo: "Motivo de su gasto",
                      hintTextImporte: "Monto de su gasto",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
