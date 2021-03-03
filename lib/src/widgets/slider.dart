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
                  child: Container(
                    child: Row(
                      children: [
                        _first(item),
                        _second(item),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: item['color'],
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
    return Container(
      width: 190.0,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 100.0,
              width: 100.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
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
