import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  LogoPage({Key key}) : super(key: key);

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 150, child: Image.asset('assets/images/logo.png'));
  }
}
