import 'package:flutter/material.dart';
import 'package:expenses_app/model/saldo_model.dart';
import 'package:provider/provider.dart';
//import 'package:math_expressions/math_expressions.dart' as math;

class FormCustom extends StatefulWidget {
  final Color color;

  final String hintTextMotivo;
  final String hintTextImporte;
  final bool esIngreso;

  const FormCustom({
    required this.color,
    required this.hintTextMotivo,
    required this.hintTextImporte,
    required this.esIngreso,
  });

  @override
  _FormCustomState createState() => _FormCustomState();
}

class _FormCustomState extends State<FormCustom> {
  TextEditingController _motivoController = TextEditingController(text: '');
  TextEditingController _importeController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final saldoModel = Provider.of<SaldoModel>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _textFormFieldCustom(
                _motivoController, "Motivo", TextInputType.text, true),
            SizedBox(height: 15),
            _textFormFieldCustom(
                _importeController, "Importe", TextInputType.number, false),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                if (this.widget.esIngreso) {
                  double ingreso = double.parse(_importeController.text);
                  saldoModel.currentSaldo = saldoModel.currentSaldo + ingreso;
                } else {
                  double gasto = double.parse(_importeController.text);
                  saldoModel.currentSaldo = saldoModel.currentSaldo - gasto;
                }
                if (_formKey.currentState!.validate()) {
                  _motivoController.clear();
                  _importeController.clear();
                }
              },
              child: Text("Agregar",
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 18)),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(100, 30)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade700),
                overlayColor: MaterialStateProperty.all(widget.color),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField _textFormFieldCustom(TextEditingController controller,
      String labelText, TextInputType type, bool esMotivo) {
    return TextFormField(
      validator: esMotivo ? validatorMotivo : validatorMonto,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: this.widget.color)),
          labelText: labelText,
          labelStyle: TextStyle(color: widget.color),
          hintText: widget.hintTextMotivo),
    );
  }

  String? validatorMonto(value) {
    if (value.length == 0) {
      return "Debe completar este campo";
    }
    //RegExp: solo numeros, enteros y dobles, sin letras, espacios y signos
    RegExp regex = new RegExp(r'[0-9][^A-z]');
    if (!regex.hasMatch(value)) {
      return "Indique el monto de forma numérica";
    }
    return null;
  }

  String? validatorMotivo(value) {
    if (value.length == 0) {
      return "Debe completar este campo";
    }
    return null;
  }
}
