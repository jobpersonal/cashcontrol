import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  final now = new DateTime.now();
  final _pref = PreferenciasUsuario();

  String dateFormatter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    dateFormatter = DateFormat.yMMMMd('en_US').format(now);
    return new Drawer(
      elevation: 30.0,
      child: Container(
        height: size.height * 1,
        color: Color(0xff2241c3).withOpacity(0.5),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 30.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "$dateFormatter",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Good day, ${_pref.nombres} !",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new ListTile(
              title: Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.east,
                color: Colors.white,
              ),
              onTap: () {},
            ),
            new ListTile(
              title: Text(
                "Cosortium",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.east,
                color: Colors.white,
              ),
            ),
            new ListTile(
              title: Text(
                "Perfil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.east,
                color: Colors.white,
              ),
            ),
            SizedBox(height: size.height * 0.58),
            new ListTile(
              title: Text(
                "Cerrar sesión",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onTap: () {
                _pref.borrarPreferencias();
                Navigator.pushNamed(context, '/');
              },
            )
          ],
        ),
      ),
    );
  }
}
