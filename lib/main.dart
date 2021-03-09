import 'package:cashcontrol/src/bloc/provider.dart';
import 'package:cashcontrol/src/myrouter.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  WidgetsFlutterBinding();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Color.fromRGBO(130, 9, 255, 1)));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "/",///create_consortium
        routes: MyRouter.routes,
      ),
    );
  }
}