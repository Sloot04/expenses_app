import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:expenses_app/model/saldo_model.dart';
//import 'package:provider/provider.dart';

class HistorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<AllMovements> todosLosMovimientos = [
      AllMovements(motivo: "super", monto: 685.2),
      AllMovements(motivo: "ropa", monto: 1000.2),
      AllMovements(motivo: "limpieza", monto: 6544.2),
      AllMovements(motivo: "comida", monto: 234.2),
      AllMovements(motivo: "viaje", monto: 685.2),
      AllMovements(motivo: "super", monto: 685.2),
      AllMovements(motivo: "ropa", monto: 1000.2),
      AllMovements(motivo: "limpieza", monto: 6544.2),
      AllMovements(motivo: "comida", monto: 234.2),
      AllMovements(motivo: "viaje", monto: 685.2),
      AllMovements(motivo: "super", monto: 685.2),
      AllMovements(motivo: "ropa", monto: 1000.2),
      AllMovements(motivo: "limpieza", monto: 6544.2),
      AllMovements(motivo: "comida", monto: 234.2),
      AllMovements(motivo: "viaje", monto: 685.2),
    ];

    // final motivo = Provider.of<SaldoModel>(context).ultimoMovimientoMotivo;
    //final monto = Provider.of<SaldoModel>(context).ultimoMovimientoMonto;

    final textStyleMotivoMonto =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

    final textStyleMap = TextStyle(fontSize: 15, fontWeight: FontWeight.w200);
    final double medida = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          children: [
            UltimosMovimientosText(),
            SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Motivo",
                              style: textStyleMotivoMonto,
                            ),
                            Text("Monto", style: textStyleMotivoMonto),
                          ]),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            ...todosLosMovimientos.map(
                              (movimiento) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(movimiento.motivo,
                                            style: textStyleMap),
                                        Text(movimiento.monto.toString(),
                                            style: textStyleMap),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: medida,
                  child: Container(
                    height: 300,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UltimosMovimientosText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.book),
            SizedBox(width: 8.0),
            Text(
              "Ultimos movimientos",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        Container(
          height: 1.0,
          width: 320.0,
          color: Colors.grey,
        ),
        SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}

class AllMovements {
  String motivo;
  double monto;

  AllMovements({required this.motivo, required this.monto}) {
    this.motivo = motivo;
    this.monto = monto;
  }

  @override
  String toString() {
    return '{ ${this.motivo}, ${this.monto} }';
  }
}
