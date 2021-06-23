import 'package:flutter/material.dart';

import 'package:expenses_app/src/widgets/bottomNavigationCustom.dart';

class HistorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historial Page")),
      body: Center(
        child: Text('Historial'),
      ),
      bottomNavigationBar: BottomNavigationCustom(),
    );
  }
}
