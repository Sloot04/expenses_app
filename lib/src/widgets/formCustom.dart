import 'package:flutter/material.dart';

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
   final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
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
                  print('motivo ingreso: ${_motivoController.text}');
                  print('importe ingreso: ${_importeController.text}');
                } else {
                  print('motivo gasto: ${_motivoController.text}');
                  print('importe gasto: ${_importeController.text}');
                }
                if (_formKey.currentState!.validate()){
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

  TextFormField _textFormFieldCustom(
      TextEditingController controller, String labelText, TextInputType type, bool esMotivo) {
    return TextFormField(
      validator: esMotivo? validatorMotivo : validatorMonto ,
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
