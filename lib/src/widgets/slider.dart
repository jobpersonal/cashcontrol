import 'package:cashcontrol/src/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderWidget extends StatefulWidget {
  final List list;
  final bool auto;
  SliderWidget({Key key, @required this.list, @required this.auto})
      : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: CarouselSlider(
          items: widget.list
              .map(
                (item) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: item['color1'],
                  child: CustomPaint(
                    painter: BackgroundPainter(item['color2']),
                    child: Container(
                      child: Row(
                        children: [
                          _first(item),
                          _second(item),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 150.0,
            autoPlay: widget.auto,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _first(item) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 30.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['meta'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item['descripcion'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                item['fecha'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _second(item) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 100.0,
              width: 100.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colores.colorMorado),
                backgroundColor: Colors.white,
                value: item['porcentage'].toDouble() / 100,
                strokeWidth: 2.0,
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${item['porcentage']} %',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  dynamic customColor;

  BackgroundPainter(this.customColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = customColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final path = Path()
      ..moveTo(0, 110)
      ..quadraticBezierTo(50, 50, 100, 100)
      ..quadraticBezierTo(150, 160, 220, 80)
      ..quadraticBezierTo(150, 150, 250, 50)
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.15, size.width, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.04)
      ..quadraticBezierTo(size.width, 0, size.width * 0.9, 0)
      ..lineTo(size.width * 0.1, 0)
      ..quadraticBezierTo(0, 0, 0, size.height * 0.04)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;
}
