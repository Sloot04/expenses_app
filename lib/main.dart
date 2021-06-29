import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/model/movimiento_model.dart';

//pages
import 'package:expenses_app/src/pages/historial_page.dart';
import 'package:expenses_app/src/pages/resumen_page.dart';
import 'package:expenses_app/src/pages/newresume_page.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovimientosModel()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  List pages = [NewResumePage(), HistorialPage(), Resumen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar: _buildBottomNavigationBar(),
          ),
        ),
      ),
    );
  }

//======BuildBottomNavigationBar======
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      selectedFontSize: 14,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          label: 'Resumen',
          icon: FaIcon(FontAwesomeIcons.piggyBank),
        ),
        BottomNavigationBarItem(
          label: 'Historial',
          icon: FaIcon(FontAwesomeIcons.book),
        ),
        BottomNavigationBarItem(
          label: 'Recordatorios?',
          icon: FaIcon(FontAwesomeIcons.clock),
        ),
      ],
    );
  }
}
