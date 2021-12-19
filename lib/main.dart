import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

import 'package:expenses_app/src/model/movimiento_model.dart';
import 'package:expenses_app/src/model/bottomNavigation_model.dart';
import 'package:expenses_app/src/model/theme_changer_model.dart';
import 'package:expenses_app/src/widgets/bottomNavigationBar_custom.dart';
import 'package:expenses_app/src/model/languaje_model.dart';
import 'package:expenses_app/src/model/event_model.dart';

Future main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
  }
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MovimientosModel()),
          ChangeNotifierProvider(create: (_) => BottomNavigationModel()),
          ChangeNotifierProvider(create: (_) => ThemeChangerModel()),
          ChangeNotifierProvider(create: (_) => EventModel()),
          ChangeNotifierProvider(create: (_) => LanguajeModel()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavigationModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: bottomProvider.pages[bottomProvider.currentIndex],
            bottomNavigationBar: BottomNavigationBarCustom(),
          ),
        ),
      ),
    );
  }
}
