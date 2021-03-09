import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/widgets/popup_navigationBar.dart';
import 'package:cashcontrol/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cashcontrol/src/utils/widgets_input.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cashcontrol/src/widgets/bottonNavigatorBar_page.dart';

class MetasPage extends StatefulWidget {
  MetasPage({Key key}) : super(key: key);

  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final PanelController _controllerPanel = new PanelController();
  final now = new DateTime.now();
  String dateFormatter;

  MoneyFormatterOutput fo;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateFormatter = DateFormat.yMMMMd('en_US').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottonNavigatorBarPage(),
        key: _scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
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
        floatingActionButton: SpeedDial(
          marginEnd: 18,
          marginBottom: 20,
          icon: Icons.add,
          activeIcon: Icons.check,
          buttonSize: 56.0,
          visible: true,
          closeManually: false,
          renderOverlay: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colores.colorAzul,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_right),
              backgroundColor: Colores.colorAzul,
              label: 'Agregar gasto',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => _showDialog('egresos'),
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_right),
              backgroundColor: Colores.colorAzul,
              label: 'Agregar deuda',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => _showDialog('deuda'),
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_right),
              backgroundColor: Colores.colorAzul,
              label: 'Agregar ingreso',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => _showDialog('ingreso'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [PopupNavigationBar(type: type)]));
        });
  }

  Widget _bodyContent() {
    return Expanded(
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [_menuItem(), _a()],
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Text(
                  'Crear Meta',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _a() {
    return Column(
      children: [
        inputText('Nombre', (value) {}),
        inputDate(context, 'Fecha Final', (value) {
          setState(() {});
          value.toString();
        }),
        inputText('Cuanto vas a meter', (value) {},
            keyboardType: TextInputType.number),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Image.asset('assets/images/camaro.jpg'))
      ],
    );
  }

  Widget _slidingUp() {
    return SlidingUpPanel(
      renderPanelSheet: false,
      minHeight: 230,
      onPanelClosed: () {
        setState(() {
          isOpen = false;
        });
      },
      onPanelOpened: () {
        setState(() {
          isOpen = true;
        });
      },
      controller: _controllerPanel,
      panel: _panelSlid(),
      collapsed: _collapseSlid(),
    );
  }

  Widget _panelSlid() {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 39),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metas",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                GestureDetector(
                  onTap: () {
                    _controllerPanel.close();
                  },
                  child: Opacity(
                    opacity: _controllerPanel.isAttached
                        ? _controllerPanel.panelPosition - 0.3 >= 0
                            ? _controllerPanel.panelPosition
                            : 0
                        : 0,
                    child: Text(
                      "Cerrar",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          _progressBar('Casa', 0.6, 'Dic 30, 2021'),
          SizedBox(
            height: 30,
          ),
          _progressBar('Casa', 0.6, 'Dic 30, 2021')
        ]),
      ),
    );
  }

  Widget _startProgressBar() {}

  Widget _collapseSlid() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 39),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metas",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                GestureDetector(
                  onTap: () {
                    _controllerPanel.open();
                  },
                  child: Text(
                    "Ver Todo",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          _progressBar('Casa', 0.6, 'Dic 30, 2021'),
          SizedBox(
            height: 30,
          ),
          _progressBar('Casa', 0.6, 'Dic 30, 2021')
        ]),
      ),
    );
  }

  Widget _progressBar(String text, double percenteje, String fecha) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(padding: EdgeInsets.only(left: 10), child: Text(text)),
            Text(fecha)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        LinearProgressIndicator(
          value: percenteje,
          minHeight: 10,
          backgroundColor: Colores.colorAzul.shade200,
          valueColor: new AlwaysStoppedAnimation<Color>(Colores.colorAzul),
        )
      ]),
    );
  }
}
