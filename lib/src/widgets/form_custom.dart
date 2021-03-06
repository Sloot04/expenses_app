import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/src/model/movimiento_model.dart';
import 'package:expenses_app/src/model/languaje_model.dart';

class FormCustom extends StatefulWidget {
  final Color color;
  final Color colorHint;
  final Color textColor;
  final String hintTextMotivo;
  final String hintTextImporte;
  final bool esIngreso;
  final double opacity;

  const FormCustom({
    required this.color,
    required this.hintTextMotivo,
    required this.hintTextImporte,
    required this.esIngreso,
    required this.colorHint,
    required this.opacity,
    required this.textColor,
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
    final movimientos = Provider.of<MovimientosModel>(context);
    final languajeModel = Provider.of<LanguajeModel>(context);

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _textFormFieldCustom(_motivoController, languajeModel.reason,
                TextInputType.text, true),
            SizedBox(height: 8),
            _textFormFieldCustom(_importeController, languajeModel.total,
                TextInputType.number, false),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                double monto = double.parse(_importeController.text);
                if (!this.widget.esIngreso) {
                  monto = monto * (-1);
                }
                Movement movement = Movement(
                    motivo: _motivoController.text,
                    monto: monto,
                    now: formattedDate(DateTime.now()));
                movimientos.addMov(movement);

                if (_formKey.currentState!.validate()) {
                  _motivoController.clear();
                  _importeController.clear();
                }
              },
              child: Text(
                languajeModel.add,
                style: TextStyle(color: Colors.grey.shade900, fontSize: 18),
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(180, 40)),
                backgroundColor: MaterialStateProperty.all(
                    widget.color.withOpacity(widget.opacity)),
                overlayColor: MaterialStateProperty.all(widget.color),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _textFormFieldCustom(
    TextEditingController controller,
    String labelText,
    TextInputType type,
    bool esMotivo,
  ) {
    return TextFormField(
      maxLength: esMotivo ? 9 : 12,
      cursorColor: widget.textColor,
      style: TextStyle(color: widget.textColor),
      validator: esMotivo ? validatorMotivo : validatorMonto,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        counter: Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.colorHint)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: this.widget.color)),
          labelText: labelText,
          labelStyle: TextStyle(color: widget.color),
          hintText: widget.hintTextImporte,
          hintStyle: TextStyle(color: widget.colorHint)),
    );
  }

  String? validatorMonto(value) {
    if (value.length == 0) {
      return "Debe completar este campo";
    }
    //RegExp: solo numeros, enteros y dobles, sin letras, espacios ni signos
    RegExp regex = new RegExp(r'^\d+(\.\d+){0,1}$');
    if (!regex.hasMatch(value)) {
      return "Indique el monto de forma num??rica";
    }
    return null;
  }

  String? validatorMotivo(value) {
    if (value.length == 0) {
      return "Debe completar este campo";
    }
    return null;
  }

  String formattedDate(DateTime dateTime) {
    var formatter = new DateFormat('dd-MM-yy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
