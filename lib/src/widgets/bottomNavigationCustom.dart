import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//Pages
import 'package:expenses_app/src/pages/historial_page.dart';
import 'package:expenses_app/src/pages/resumen_page.dart';

class BottomNavigationCustom extends StatefulWidget {
  @override
  _BottomNavigationCustomState createState() => _BottomNavigationCustomState();
}

class _BottomNavigationCustomState extends State<BottomNavigationCustom> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResumenPage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistorialPage()));
              break;
            default:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResumenPage()));
          }
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
      ),
    );
  }
}
