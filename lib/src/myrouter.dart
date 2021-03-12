
import 'package:cashcontrol/src/pages/consortium/create.page.dart';
import 'package:flutter/material.dart' show WidgetBuilder;
import 'package:cashcontrol/src/pages/auth/home_page.dart';
import 'package:cashcontrol/src/pages/auth/login_page.dart';
import 'package:cashcontrol/src/pages/auth/recordar_clave.dart';
import 'package:cashcontrol/src/pages/auth/registrarse_page.dart';
import 'package:cashcontrol/src/pages/dashboard.dart';
import 'package:cashcontrol/src/pages/dashboardConsortium.dart';
import 'package:cashcontrol/src/pages/deuda_page.dart';
import 'package:cashcontrol/src/pages/history_page.dart';
import 'package:cashcontrol/src/pages/metas_page.dart';
import 'package:cashcontrol/src/widgets/egreso.dart';
import 'package:cashcontrol/src/widgets/ingreso.dart';
import 'package:flutter/cupertino.dart';


class MyRouter {
  static final Map<String, WidgetBuilder> _routes = {
    '/': (_) => HomePage(),
    '/login': (BuildContext context) => LoginPage(),
    '/registrarse': (BuildContext context) => RegistrarsePage(),
    '/recordar': (BuildContext context) => RecordarClavePage(),
    '/dashboard': (BuildContext context) => DashboardPage(),
    '/history': (BuildContext context) => HistoryPage(),
    '/consortium': (BuildContext context) => DashboardConsortiumPage(),
    '/metas': (BuildContext context) => MetasPage(),
    '/create_consortium': (BuildContext context) => ConsortiumCreatePage(),
    '/deuda': (BuildContext context) => DeudaPage(),
    '/egreso': (BuildContext context) => EgresosWidget(),
    '/ingreso': (BuildContext context) => IngresosWidget(),
  };
  static Map<String, WidgetBuilder> get routes => _routes;
}