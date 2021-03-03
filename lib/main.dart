import 'package:cashcontrol/src/myrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
<<<<<<< HEAD
      title: 'Material App',
=======
      debugShowCheckedModeBanner: false,
>>>>>>> 1f4bf09e2b23c949dd32adc7240e244b0f044f87
      initialRoute: '/',
      routes: MyRouter.routes,
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 1f4bf09e2b23c949dd32adc7240e244b0f044f87
