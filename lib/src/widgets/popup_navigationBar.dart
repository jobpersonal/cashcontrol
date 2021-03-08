import 'package:flutter/material.dart';
import 'package:cashcontrol/src/utils/widgets_input.dart';

class PopupNavigationBar extends StatefulWidget {
  String type;
  PopupNavigationBar({this.type});

  @override
  _PopupNavigationBarState createState() => _PopupNavigationBarState();
}

class _PopupNavigationBarState extends State<PopupNavigationBar> {
  // String _concepto = '';
  // String _periodisidad = '';
  // String _fechaVencimiento = '';
  // String _tipoDeuda = '';
  // String _valorDeuda = '';
  String _fechaVencimiento = '';
  Map<String, String> datos = {};
  TextEditingController searchCtrl;

  List<Widget> _switch(String param) {
    switch (param) {
      case 'deuda':
        return [
          Text(
            'Agregar deuda',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          inputText('Concepto', (value) {
            datos['concepto'] = value;
          }),
          inputList('Periosidad', (value) {
            datos['periosidad'] = value;
          }, [
            'Diario',
            'Semanal',
            'Quincena',
            'Mensual',
            'Semestral',
            'Anual'
          ]),
          inputDate(context, 'Fecha vencimiento', (value) {
            datos['fechaVencimiento'] = value;
          }, DateTime.now()),
          inputList('Tipo de deuda', (value) {
            datos['tipoDeuda'] = value;
          }, ['Tipo 1', 'Tipo 2']),
          inputText('Valor de la deuda', (value) {
            datos['valorDeuda'] = value;
          }),
          _button()
        ];
        break;
      case 'egresos':
        return [
          Text(
            'Agregar Gasto',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          inputText('Concepto', (value) {
            datos['concepto'] = value;
          }),
          inputText('Valor', (value) {
            datos['valor'] = value;
          }),
          _button()
        ];
        break;
      case 'ingreso':
        return [
          Text(
            'Agregar ingreso',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          inputText('Concepto', (value) {
            datos['concepto'] = value;
          }),
          inputList('Periosidad', (value) {
            datos['periosidad'] = value;
          }, [
            'Diario',
            'Semanal',
            'Quincena',
            'Mensual',
            'Semestral',
            'Anual'
          ]),
          inputDate(context, 'Fecha vencimiento', (value) {
            datos['fechaVencimiento'] = value;
          }),
          inputList('Tipo ingreso', (value) {
            datos['tipoIngreso'] = value;
          }, ['Salario', 'Inversiones']),
          inputText('Valor', (value) {
            datos['valor'] = value;
          }),
          _button()
        ];
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7d00ff), Color(0xffBD7DFF)])),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(children: _switch(widget.type)),
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
