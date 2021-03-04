import 'package:flutter/material.dart';

class EgresosWidget extends StatefulWidget {
  @override
  _EgresosWidgetState createState() => _EgresosWidgetState();
}

class _EgresosWidgetState extends State<EgresosWidget> {
  String _concepto = '';
  String _valor = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7d00ff), Color(0xffBD7DFF)])),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          children: [
            Text(
              'Agregar Gasto',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            _inputText('Concepto', (value) {
              _concepto = value;
            }),
            _inputText('Valor', (value) {
              _valor = value;
            }),
            _button()
          ],
        ),
      ),
    );
  }

  Widget _inputText(String name, Function callback) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextFormField(
        onChanged: callback,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          hintText: name,
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return FlatButton(
        onPressed: null,
        child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xff2406d6),
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            )));
  }
}
