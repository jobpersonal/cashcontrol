import 'package:cashcontrol/src/pages/floatingActionButton.dart';
import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/widgets/menu_lateral.dart';
import 'package:cashcontrol/src/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
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
      'color': Colores.colorMorado,
    },
    {
      'meta': 'Ferrari',
      'descripcion': 'La Ferrari',
      'fecha': 'Diciembre 2022',
      'porcentage': 20,
      'color': Color(0xff069FD6),
    },
  ];

  String search = "";

  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo;
  FlutterMoneyFormatter fmf1 = FlutterMoneyFormatter(amount: 0.0);
  MoneyFormatterOutput fo1;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isOpen = false;
  List items = [];
  List _searchResult = [];
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateFormatter = DateFormat.yMMMMd('en_US').format(now);
    fmf = FlutterMoneyFormatter(amount: value.toDouble());
    fo = fmf.output;
    // esto es para la animacion
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset(0.0, 0.0))
        .animate(controller);
    //esto se pone en la consulta al api para convertir el valor de las deudas en formato moneda
    for (var i = 0; i < 15; i++) {
      fmf1 = FlutterMoneyFormatter(amount: 350000.toDouble());
      fo1 = fmf1.output;
      items.add(
        {
          'texto': 'Este es la deuda $i',
          'fecha': 'Marzo $i',
          'valor': fo1.symbolOnLeft,
          'pagado': false,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: MenuLateral(),
        ),
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
                _bodyContent(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) =>
                    FloatingActionButtonPage(),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colores.colorAzul,
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return Expanded(
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                _menuItem(),
                if (!isOpen)
                  AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(seconds: 5),
                    child: _bannerText(),
                  ),
                SizedBox(
                  height: 15.0,
                ),
                SliderWidget(list: slider, auto: false),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
            _slidingUp(),
          ],
        ),
      ),
    );
  }

  Widget _menuItem() {
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
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            Row(
              children: [
                if (isOpen) _contentTextMenu(),
                SizedBox(
                  width: 10.0,
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

  Widget _slidingUp() {
    return SlidingUpPanel(
      renderPanelSheet: false,
      onPanelClosed: () {
        controller.reverse();
        setState(() {
          isOpen = false;
        });
      },
      onPanelOpened: () {
        controller.forward();
        setState(() {
          isOpen = true;
        });
      },
      panel: _panelSlid(),
      collapsed: _collapseSlid(),
    );
  }

  Widget _panelSlid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Opacity(
          opacity: isOpen ? 1.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 20.0,
              right: 20.0,
            ),
            child: SlideTransition(
              position: offset,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _linea(),
                  Text(
                    'Deudas',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  _fieldSearch(),
                  _contenidoPanel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _contenidoPanel() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (_searchResult.length != 0)
              for (var item in _searchResult)
                CheckboxListTile(
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['texto'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: item['pagado']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            Text(
                              '${item['valor']}',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${item['fecha']}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: item['pagado']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: item['pagado'],
                  onChanged: (newValue) {
                    setState(() {
                      item['pagado'] = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
            if (_searchResult.length == 0)
              for (var item in items)
                CheckboxListTile(
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['texto'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: item['pagado']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            Text(
                              '${item['valor']}',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${item['fecha']}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: item['pagado']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: item['pagado'],
                  onChanged: (newValue) {
                    setState(() {
                      item['pagado'] = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    items.forEach((element) {
      if ((element['texto']).toUpperCase().contains((text).toUpperCase()) ||
          element['valor'].contains(text)) _searchResult.add(element);
    });

    setState(() {});
  }

  Widget _fieldSearch() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Consultar',
          labelStyle: TextStyle(
            color: Color(0xffcdd0d1),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(Icons.search),
          ),
        ),
        onChanged: onSearchTextChanged,
      ),
    );
  }

  Widget _linea() {
    return Center(
      child: Container(
        height: 1.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _collapseSlid() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _linea(),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Deudas",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                Text(
                  "Ver Todo",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentTextMenu() {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 5),
      child: Column(
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
    );
  }
}
