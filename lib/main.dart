import 'package:cashcontrol/src/bloc/provider.dart';
import 'package:cashcontrol/src/myrouter.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:flutter/material.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  WidgetsFlutterBinding();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "/",
        routes: MyRouter.routes,
      ),
    );
  }
}
