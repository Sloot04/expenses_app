import 'package:flutter/material.dart';

import 'package:expenses_app/src/model/bottomNavigation_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavigationModel>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      selectedFontSize: 14,
      showUnselectedLabels: false,
      currentIndex: bottomProvider.currentIndex,
      onTap: (index) {
        bottomProvider.currentIndex = index;
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
