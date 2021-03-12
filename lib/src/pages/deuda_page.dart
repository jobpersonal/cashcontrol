import 'package:flutter/material.dart';
import 'package:cashcontrol/src/widgets/deuda.dart';

class DeudaPage extends StatefulWidget {
  DeudaPage({Key key}) : super(key: key);

  @override
  _DeudaPageState createState() => _DeudaPageState();
}

class _DeudaPageState extends State<DeudaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: DeudaWidget(),
    );
  }
}
