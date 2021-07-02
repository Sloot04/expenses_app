import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleCustom extends StatelessWidget {
  final String title;
  final IconData icon;
  final double underline;
  final bool animated;

  TitleCustom({
    required this.title,
    required this.icon,
    this.underline = 250.0,
    this.animated = true,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animated
                ? BounceInLeft(from: 130, child: FaIcon(this.icon))
                : BounceInDown(child: FaIcon(this.icon)),
            SizedBox(width: 8.0),
            Text(
              this.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        Container(
          height: 1.0,
          width: this.underline,
          color: Colors.grey,
        ),
        SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
