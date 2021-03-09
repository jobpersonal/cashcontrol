import 'package:cashcontrol/src/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  final now = new DateTime.now();

  String dateFormatter;

  String user = "Mateo";

  @override
  Widget build(BuildContext context) {
    dateFormatter = DateFormat.yMMMMd('en_US').format(now);
    return new Drawer(
      elevation: 30.0,
      child: Container(
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
                      "Good day, $user !",
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
            )
          ],
        ),
      ),
    );
  }
}
