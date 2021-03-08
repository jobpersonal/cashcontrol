import 'package:flutter/material.dart';
import 'backgound_painter.widget.dart';

Widget customCard(Widget child, {Color color1, Color color2, double height}) {    
  return Card(
    color: color1,
    child: Stack(
      children: [
        formsBackground(color2, height),
        child,
      ],
    ),
  );
}

