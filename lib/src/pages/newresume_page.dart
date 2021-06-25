import 'package:flutter/material.dart';

import 'package:expenses_app/src/widgets/formCustom.dart';

class NewResumePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Text("\$0.0"),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  children: [
                    FormCustom(
                      color: Colors.green,
                      hintTextMotivo: "Motivo de su ingreso",
                      hintTextImporte: "Monto de su ingreso",
                    ),
                    SizedBox(height: 20),
                    FormCustom(
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
