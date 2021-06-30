import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/src/model/movimiento_model.dart';
import 'package:expenses_app/src/model/bottomNavigation_model.dart';
import 'package:expenses_app/src/widgets/bottomNavigationBar_custom.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MovimientosModel()),
          ChangeNotifierProvider(create: (_) => BottomNavigationModel()),
        ],
        child: MyApp(),
      ),
    );

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
            body: bottomProvider.pages[bottomProvider.currentIndex],
            bottomNavigationBar: BottomNavigationBarCustom(),
          ),
        ),
      ),
    );
  }
}
