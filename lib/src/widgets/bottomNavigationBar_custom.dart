import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/src/model/bottomNavigation_model.dart';
import 'package:expenses_app/src/model/idiom_model.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavigationModel>(context);
    final idiomModel = Provider.of<IdiomModel>(context);

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
          label: idiomModel.resume,
          icon: FaIcon(FontAwesomeIcons.piggyBank),
        ),
        BottomNavigationBarItem(
          label: idiomModel.record,
          icon: FaIcon(FontAwesomeIcons.book),
        ),
        BottomNavigationBarItem(
          label: idiomModel.reminders,
          icon: FaIcon(FontAwesomeIcons.clock),
        ),
      ],
    );
  }
}
