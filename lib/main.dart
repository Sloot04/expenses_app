import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//pages
import 'package:expenses_app/src/pages/historial_page.dart';
import 'package:expenses_app/src/pages/resumen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  List pages = [ResumenPage(), HistorialPage(), ResumenPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

//======BuildBottomNavigationBar======
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
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
          icon: FaIcon(FontAwesomeIcons.coins),
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
