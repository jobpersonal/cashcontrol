import 'package:cashcontrol/src/pages/dashboard.dart';
import 'package:cashcontrol/src/pages/metas_page.dart';
import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/widgets/menu_lateral.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black12,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.map, size: 30),
          Icon(Icons.qr_code, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Container(
        color: Color(0xff7D00FF),
        child: Center(
          child: choosePage(),
        ),
      ),
    );
  }

  choosePage() {
    if (_page == 0) {
      return MetasPage();
    }
    if (_page == 1) {
      return Container();
    }
    if (_page == 2) {
      return Container();
    }
  }
}
