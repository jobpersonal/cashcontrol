import 'package:cashcontrol/src/pages/consortium/create.page.dart';
import 'package:cashcontrol/src/pages/home_page.dart';
import 'package:flutter/material.dart' show WidgetBuilder;

class MyRouter {
  static final Map<String, WidgetBuilder> _routes = {
    '/': (_) => HomePage(),
    '/create_consortium': (_) => ConsortiumCreatePage()
  };
  static Map<String, WidgetBuilder> get routes => _routes;
}
