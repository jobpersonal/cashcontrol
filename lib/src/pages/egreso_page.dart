import 'package:cashcontrol/src/widgets/egreso.dart';
import 'package:flutter/material.dart';

class EgresoPage extends StatefulWidget {
  EgresoPage({Key key}) : super(key: key);

  @override
  _EgresoPageState createState() => _EgresoPageState();
}

class _EgresoPageState extends State<EgresoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: EgresosWidget(),
    );
  }
}
