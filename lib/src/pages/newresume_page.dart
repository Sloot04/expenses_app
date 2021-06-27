import 'package:flutter/material.dart';

import 'package:expenses_app/src/widgets/formCustom.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/model/saldo_model.dart';

class NewResumePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentsaldo = Provider.of<SaldoModel>(context).currentSaldo;

    return Scaffold(
      appBar: AppBar(
        title: Text('NewResumen'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              _SaldoText(),
              Text("\$$currentsaldo"),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  children: [
                    FormCustom(
                      color: Colors.green,
                      esIngreso: true,
                      hintTextMotivo: "Motivo de su ingreso",
                      hintTextImporte: "Monto de su ingreso",
                    ),
                    SizedBox(height: 20),
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

class _SaldoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Mi saldo',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        color: Colors.black,
      ),
    );
  }
}
