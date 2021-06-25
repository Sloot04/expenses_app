import 'package:flutter/material.dart';

class FormCustom extends StatelessWidget {
  final Color color;

  final String hintTextMotivo;
  final String hintTextImporte;

  const FormCustom({
    required this.color,
    required this.hintTextMotivo,
    required this.hintTextImporte,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: this.color)),
                  labelText: "Motivo",
                  labelStyle: TextStyle(color: color),
                  hintText: hintTextMotivo),
            ),
            SizedBox(height: 15),
            TextFormField(
             keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: this.color)),
                  labelText: "Importe",
                  labelStyle: TextStyle(color: color),
                  hintText: hintTextImporte),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              child: Text("Agregar",
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 18)),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(100, 30)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade700),
                overlayColor: MaterialStateProperty.all(color),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
