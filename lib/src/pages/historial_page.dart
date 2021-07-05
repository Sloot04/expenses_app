import 'package:expenses_app/src/widgets/title_custom.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/src/model/movimiento_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listaMovimiento =
        Provider.of<MovimientosModel>(context).listaMovimientos.reversed;
    final colorText = TextStyle(color: Colors.white);
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              TitleCustom(
                icon: FontAwesomeIcons.book,
                title: 'Últimos movimientos',
                underline: 320.0, titleColor: Colors.black,
              ),
              SizedBox(height: 25.0),
              if (listaMovimiento.length == 0)
                Text(
                  "No se registraron últimos movimientos",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              if (listaMovimiento.length > 0)
                dataTableCustom(colorText, listaMovimiento),
            ],
          ),
        ),
      ),
    );
  }

  Container dataTableCustom(TextStyle colorText, listaMovimiento) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      height: 250,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FadeIn(
          duration: Duration(milliseconds: 300),
          child: DataTable(
            showBottomBorder: true,
            dividerThickness: 2,
            dataRowHeight: 30,
            headingRowColor: MaterialStateProperty.all(Colors.black87),
            headingRowHeight: 40,
            columns: [
              DataColumn(label: Text('Motivo', style: colorText)),
              DataColumn(label: Text('Monto', style: colorText)),
              DataColumn(label: Text('Fecha', style: colorText)),
            ],
            rows: dataRow(listaMovimiento),
          ),
        ),
      ),
    );
  }

  List<DataRow> dataRow(listaMovimiento) {
    final List<DataRow> lista = listaMovimiento.map<DataRow>((movimiento) {
      return DataRow(
          color: (movimiento.monto.toString()[0] == '-')
              ? MaterialStateProperty.all(Colors.red.withOpacity(0.2))
              : MaterialStateProperty.all(Colors.green.withOpacity(0.2)),
          cells: <DataCell>[
            DataCell(Text(movimiento.motivo)),
            DataCell(Text('\$' + movimiento.monto.toString())),
            DataCell(Text(movimiento.now)),
          ]);
    }).toList();
    return lista;
  }
}
