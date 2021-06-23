import 'package:flutter/material.dart';

import 'package:expenses_app/src/widgets/bottomNavigationCustom.dart';
import 'package:expenses_app/src/pages/resumen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: Scaffold(
        body: ResumenPage(),
        bottomNavigationBar: BottomNavigationCustom(),
      ),
    );
  }
}
