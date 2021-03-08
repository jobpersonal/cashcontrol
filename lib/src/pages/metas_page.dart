import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/widgets/bottonNavigatorBar_page.dart';
import 'package:cashcontrol/src/widgets/popup_navigationBar.dart';
import 'package:cashcontrol/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cashcontrol/src/utils/widgets_input.dart';
import 'package:popover/popover.dart';

class MetasPage extends StatefulWidget {
  MetasPage({Key key}) : super(key: key);

  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
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
            // _showDialog();
            showPopover(
              context: context,
              bodyBuilder: (context) => Text('Hola'),
              onPop: () => print('Popover was popped!'),
              direction: PopoverDirection.bottom,
              width: 200,
              height: 400,
              arrowHeight: 15,
              arrowWidth: 30,
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colores.colorAzul,
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [PopupNavigationBar(type: 'egresos')]));
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
                Text(
                  "Ver Todo",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(left: 60, right: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10), child: Text('Casa')),
                  Text('Dic 30, 2021')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 0.5,
                minHeight: 10,
                backgroundColor: Colores.colorAzul.shade200,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colores.colorAzul),
              )
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 60, right: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10), child: Text('Casa')),
                  Text('Dic 30, 2021')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 0.5,
                minHeight: 10,
                backgroundColor: Colores.colorAzul.shade200,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colores.colorAzul),
              )
            ]),
          ),
        ]),
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
                Text(
                  "Ver Todo",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(left: 60, right: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10), child: Text('Casa')),
                  Text('Dic 30, 2021')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 0.5,
                minHeight: 10,
                backgroundColor: Colores.colorAzul.shade200,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colores.colorAzul),
              )
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 60, right: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10), child: Text('Casa')),
                  Text('Dic 30, 2021')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 0.5,
                minHeight: 10,
                backgroundColor: Colores.colorAzul.shade200,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colores.colorAzul),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
