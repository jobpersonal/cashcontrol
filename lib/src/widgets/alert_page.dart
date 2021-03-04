import 'package:flutter/material.dart';

class AlertaPage extends StatefulWidget {
  AlertaPage({Key key}) : super(key: key);

  @override
  _AlertaPageState createState() => _AlertaPageState();
}

class _AlertaPageState extends State<AlertaPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ));
  }
}
