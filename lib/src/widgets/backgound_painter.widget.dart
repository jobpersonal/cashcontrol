import 'package:flutter/material.dart';

Widget formsBackground(Color color, double height) => Align(
      alignment: Alignment.bottomCenter,
      child: CustomPaint(
        foregroundPainter: BackgroundPainter(color),
        child: Container(height: height),
      ),
    );

class BackgroundPainter extends CustomPainter {
  final Color color;
  BackgroundPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final path = Path()
      ..moveTo(0, size.height * .3)
      ..quadraticBezierTo(50, size.height * .5, 100, size.height *.55)
      ..quadraticBezierTo(150, size.height * .7, 220, size.height *.4)
      ..quadraticBezierTo(150, size.height * .6, 250, size.height *.3)
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.15, size.width, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.04)
      ..quadraticBezierTo(size.width, 0, size.width * 0.9, 0)
      ..lineTo(size.width * 0.1, 0)
      ..quadraticBezierTo(0, 0, 0, size.height * 0.04)
      ..close();
      // ..moveTo(0, 110)
      // ..quadraticBezierTo(50, 50, 100, 100)
      // ..quadraticBezierTo(150, 160, 220, 80)
      // ..quadraticBezierTo(150, 150, 250, 50)
      // ..quadraticBezierTo(
      //     size.width * 0.9, size.height * 0.15, size.width, size.height * 0.2)
      // ..lineTo(size.width, size.height * 0.04)
      // ..quadraticBezierTo(size.width, 0, size.width * 0.9, 0)
      // ..lineTo(size.width * 0.1, 0)
      // ..quadraticBezierTo(0, 0, 0, size.height * 0.04)
      // ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;
}
