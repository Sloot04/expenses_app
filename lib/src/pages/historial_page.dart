import 'package:flutter/material.dart';
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

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          children: [
            Text("Ultimos movimientos"),
            SizedBox(height: 20),
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
          ],
        ),
      ),
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
