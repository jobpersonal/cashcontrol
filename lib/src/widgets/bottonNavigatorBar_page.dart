import 'package:cashcontrol/src/pages/history_page.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:cashcontrol/src/utils/colores.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottonNavigatorBarPage extends StatefulWidget {
  BottonNavigatorBarPage({Key key}) : super(key: key);

  @override
  _BottonNavigatorBarPageState createState() => _BottonNavigatorBarPageState();
}

class _BottonNavigatorBarPageState extends State<BottonNavigatorBarPage> {
  int _page = 0;
  final _pref = PreferenciasUsuario();

  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.black12,
      index: _pref.tap,
      key: _bottomNavigationKey,
      items: <Widget>[
        Icon(Icons.payment, size: 30),
        Icon(Icons.calendar_today, size: 30),
        Icon(Icons.unarchive_rounded, size: 30),
        Icon(Icons.monetization_on, size: 30),
        Icon(Icons.people_alt, size: 30),
        Icon(Icons.stacked_bar_chart, size: 30),
      ],
      color: Colors.white,
      animationDuration: Duration(milliseconds: 600),
      onTap: (valor) {
        setState(() {
          _pref.recordarTap = valor;
          _page = valor;
          choosePage(_page, context);
        });
      },
    );
  }

  choosePage(int _page, BuildContext context) {
    if (_page == 0) {
      Navigator.pushNamed(context, '/dashboard');
    }
    if (_page == 1) {
      //Navigator.pushNamed(context, '/history');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HistoryPage( title: 'Historial', backgroundPageColor: Colores.primnary, fromTo: 'history',))
      );
    }
    if (_page == 3) {
      Navigator.pushNamed(context, '/metas');
    }
    if (_page == 4) {
      Navigator.pushNamed(context, '/create_consortium');
    }
    if (_page == 5) {
      //Navigator.pushNamed(context, '/chart');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HistoryPage( title: 'Reportes', backgroundPageColor: Colores.blue1, fromTo: 'chart',))
      );
    }
  }
}
