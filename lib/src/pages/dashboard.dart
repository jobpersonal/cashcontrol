import 'package:cashcontrol/src/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final now = new DateTime.now();
  String dateFormatter;
  String user = "Mateo";
  String disponible = "Disponible";
  double value = 1850350;
  String saludo = "Good day";
  List slider = [
    {
      'meta': 'Chevrollet',
      'descripcion': 'camaro',
      'fecha': 'Diciembre 2021',
      'porcentage': 75,
      'color': Color(0xff2406D6),
    },
    {
      'meta': 'Ferrari',
      'descripcion': 'La Ferrari',
      'fecha': 'Diciembre 2022',
      'porcentage': 20,
      'color': Color(0xff069FD6),
    },
  ];

  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateFormatter = DateFormat.yMMMMd('en_US').format(now);
    fmf = FlutterMoneyFormatter(amount: value.toDouble());
    fo = fmf.output;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,     
                colors: [
                  Color(0xff7D00FF),
                  Color(0xffBD7DFF),
                ],                     
              ),
            ),
            child: Column(
              children: [
                _bannerMenu(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
        ),
      ),
    );
  }

  Widget _bannerMenu() {
    return Container(
      child: Column(
        children: [
          _menuItem(),
          _bannerText(),
          SliderWidget(list: slider, auto: false),
        ],
      ),
    );
  }

  Widget _menuItem() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
        left: 10.0,
        right: 15.0,
      ),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: null,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerText() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _itemsLeft(),
            _itemsRigth(),
          ],
        ),
      ),
    );
  }

  Widget _itemsLeft() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$dateFormatter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '$saludo , $user !',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemsRigth() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$disponible',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '${fo.symbolOnLeft}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
