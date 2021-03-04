import 'package:cashcontrol/src/pages/auth/home_page.dart';
import 'package:cashcontrol/src/pages/auth/login_page.dart';
import 'package:cashcontrol/src/pages/auth/recordar_clave.dart';
import 'package:cashcontrol/src/pages/auth/registrarse_page.dart';
import 'package:flutter/cupertino.dart';

class MyRouter {
  static final Map<String, WidgetBuilder> _routes = {
    '/': (_) => HomePage(),
    '/login': (BuildContext context) => LoginPage(),
    '/registrarse': (BuildContext context) => RegistrarsePage(),
    '/recordar': (BuildContext context) => RecordarClavePage(),
  };
  static Map<String, WidgetBuilder> get routes => _routes;
}
