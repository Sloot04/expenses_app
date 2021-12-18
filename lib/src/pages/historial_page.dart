import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/src/model/movimiento_model.dart';
import 'package:expenses_app/src/model/languaje_model.dart';
import 'package:expenses_app/src/model/theme_changer_model.dart';
import 'package:expenses_app/src/widgets/title_custom.dart';

class HistorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listaMovimiento =
        Provider.of<MovimientosModel>(context).listaMovimientos.reversed;
    final colors = Provider.of<ThemeChangerModel>(context);
    final languajeModel = Provider.of<LanguajeModel>(context);
    final colorText = TextStyle(color: Colors.white);
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 45),
          child: Column(
            children: [
              TitleCustom(
                icon: FontAwesomeIcons.book,
                title: languajeModel.lastMovements,
                underline: 320.0,
                titleColor: colors.titleColor,
              ),
              SizedBox(height: 25.0),
              if (listaMovimiento.length == 0)
                Text(
                  languajeModel.noLastMovements,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              if (listaMovimiento.length > 0)
                dataTableCustom(colorText, listaMovimiento, context),
            ],
          ),
        ),
      ),
    );
  }

  Container dataTableCustom(TextStyle colorText, listaMovimiento, context) {
    final languajeModel = Provider.of<LanguajeModel>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
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
            headingRowColor: MaterialStateProperty.all(Colors.black),
            headingRowHeight: 40,
            columns: [
              DataColumn(label: Text(languajeModel.reason, style: colorText)),
              DataColumn(label: Text(languajeModel.amount, style: colorText)),
              DataColumn(label: Text(languajeModel.date, style: colorText)),
            ],
            rows: dataRow(listaMovimiento, context),
          ),
        ),
      ),
    );
  }

  List<DataRow> dataRow(listaMovimiento, context) {
    final isDark = Provider.of<ThemeChangerModel>(context).isDark;
    final colors = Provider.of<ThemeChangerModel>(context);
    final textStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.w300);
    final List<DataRow> lista = listaMovimiento.map<DataRow>((movimiento) {
      return DataRow(
          color: (movimiento.monto.toString()[0] == '-')
              ? MaterialStateProperty.all(
                  Colors.red.withOpacity(colors.opacity))
              : MaterialStateProperty.all(
                  Colors.green.withOpacity(colors.opacity)),
          cells: <DataCell>[
            DataCell(Expanded(
              child: Text(
                movimiento.motivo,
                style: isDark ? textStyle : null,
              ),
            )),
            DataCell(Expanded(
              child: Text('\$' + movimiento.monto.toString(),
                  style: isDark ? textStyle : null),
            )),
            DataCell(Text(movimiento.now, style: isDark ? textStyle : null)),
          ]);
    }).toList();
    return lista;
  }
}
