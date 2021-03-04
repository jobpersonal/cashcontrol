import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/utils/widgets.dart';
import 'package:cashcontrol/src/widgets/deuda.dart';
import 'package:cashcontrol/src/widgets/egresos.dart';
import 'package:flutter/material.dart';
import 'package:cashcontrol/src/utils/popup.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, String> datos = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  _bannerMenu(),
                  _alertAdd(),
                  inputText('Concepto', (value) {
                    datos['concepto'] = value;
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _alertAdd() {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        _showDialog();
      },
    );

    return okButton;
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [WidgetsExports(type: 'egresos')]));
        });
  }

  Widget _bannerMenu() {
    return Container(
      child: Row(
        children: [
          _menuItem(),
        ],
      ),
    );
  }

  Widget _menuItem() {
    return Container();
  }
}
