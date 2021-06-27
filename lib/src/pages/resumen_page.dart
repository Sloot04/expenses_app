import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart' as me;

class Resumen extends StatefulWidget {
  @override
  _ResumenState createState() => _ResumenState();
}

class Descripcion {
  String motivo;
  String monto;

  Descripcion(this.motivo, this.monto);
  @override
  String toString() {
    return "$motivo: $monto";
  }
}

class _ResumenState extends State<Resumen> {
  String balance = '0.0';
  List<Descripcion> motivosGastos = [];
  final GlobalKey<FormState> _formKeyIngresos = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyGastos = GlobalKey<FormState>();

  TextEditingController _textControllerIngresos =
      TextEditingController(text: "");
  TextEditingController _motivoControllerIngresos =
      TextEditingController(text: "");
  TextEditingController _textControllerGastos = TextEditingController(text: "");
  TextEditingController _motivoControllerGastos =
      TextEditingController(text: "");
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Container(
              color: Colors.transparent, //con esto funciona GestureDetector
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mi saldo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      FaIcon(FontAwesomeIcons.piggyBank)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$ $balance',
                      style: TextStyle(
                        color: balance[0] == '-'
                            ? Colors.redAccent
                            : Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Wrap(
                        runAlignment: WrapAlignment.spaceBetween,
                        runSpacing: 20,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 20,
                        children: [
                          Form(
                            key: _formKeyIngresos,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: validatorMotivo,
                                  controller: _motivoControllerIngresos,
                                  decoration: buildInputDecoration(
                                      Colors.greenAccent,
                                      "Motivo",
                                      "Motivo de su ingreso"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: validatorMonto,
                                  controller: _textControllerIngresos,
                                  decoration: buildInputDecoration(
                                      Colors.greenAccent,
                                      "Importe",
                                      "Monto de su ingreso"),
                                  keyboardType: TextInputType.number,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: ElevatedButton(
                                      style:
                                          buildButtonStyle(Colors.greenAccent),
                                      onPressed: () {
                                        if (_formKeyIngresos.currentState!
                                            .validate()) {
                                          balanceFinal(
                                              balance,
                                              '+',
                                              _textControllerIngresos.text,
                                              _motivoControllerIngresos.text);
                                          _textControllerIngresos.clear();
                                          _motivoControllerIngresos.clear();
                                        } else {
                                          _textControllerIngresos.clear();
                                          _motivoControllerIngresos.clear();
                                        }
                                      },
                                      child: Text(
                                        "Agregar",
                                        style: TextStyle(
                                            color: Colors.grey.shade900),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Form(
                            key: _formKeyGastos,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: validatorMotivo,
                                  controller: _motivoControllerGastos,
                                  decoration: buildInputDecoration(
                                      Colors.redAccent,
                                      "Motivo",
                                      "Motivo de su gasto"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: validatorMonto,
                                  controller: _textControllerGastos,
                                  decoration: buildInputDecoration(
                                      Colors.redAccent,
                                      "Importe",
                                      "Monto de su gasto"),
                                  keyboardType: TextInputType.number,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: ElevatedButton(
                                        style:
                                            buildButtonStyle(Colors.redAccent),
                                        onPressed: () {
                                          if (_formKeyGastos.currentState!
                                              .validate()) {
                                            balanceFinal(
                                                balance,
                                                '-',
                                                _textControllerGastos.text,
                                                _motivoControllerGastos.text);
                                            _textControllerGastos.clear();
                                            _motivoControllerGastos.clear();
                                          } else {
                                            _textControllerGastos.clear();
                                            _motivoControllerGastos.clear();
                                          }
                                        },
                                        child: Text(
                                          "Agregar",
                                          style: TextStyle(
                                              color: Colors.grey.shade900),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validatorMonto(value) {
    if (value?.length == 0) {
      return "Debe completar este campo";
    }
    RegExp regex = new RegExp(r'[0-9]');
    if (!regex.hasMatch(value!)) {
      return "Indique el monto de forma numérica";
    }
    return null;
  }

  String? validatorMotivo(value) {
    if (value?.length == 0) {
      return "Debe completar este campo";
    }
    return null;
  }

  ButtonStyle buildButtonStyle(color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.grey.shade700),
      overlayColor: MaterialStateProperty.all(color),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  InputDecoration buildInputDecoration(color, String label, String hint) {
    return InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
        labelText: label,
        labelStyle: TextStyle(color: color),
        hintText: hint);
  }

  void balanceFinal(
      String balanceActual, String signo, String monto, String motivo) {
    setState(() {
      final String _expression = "$balanceActual $signo $monto";
      me.Expression e = me.Parser().parse(_expression);

      double result = e.evaluate(
        me.EvaluationType.REAL,
        me.ContextModel(),
      );
      this.balance = result.toString();
    });

    motivosGastos.add(Descripcion(
      motivo,
      monto,
    ));
  }
}
