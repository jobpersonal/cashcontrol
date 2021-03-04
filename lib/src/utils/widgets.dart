import 'package:flutter/material.dart';

class WidgetsExports extends StatefulWidget {
  String type;
  WidgetsExports({this.type});

  @override
  _WidgetsExportsState createState() => _WidgetsExportsState();
}

class _WidgetsExportsState extends State<WidgetsExports> {
  // String _concepto = '';
  // String _periodisidad = '';
  // String _fechaVencimiento = '';
  // String _tipoDeuda = '';
  // String _valorDeuda = '';
  String _fechaVencimiento = '';
  Map<String, String> datos = {};

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
          _inputText('Concepto', (value) {
            datos['concepto'] = value;
          }),
          _inputList('Periosidad', (value) {
            datos['periosidad'] = value;
          }, [
            'Diario',
            'Semanal',
            'Quincena',
            'Mensual',
            'Semestral',
            'Anual'
          ]),
          _dateInput('Fecha vencimiento', (value) {
            datos['fechaVencimiento'] = value;
          }),
          _inputList('Tipo de deuda', (value) {
            datos['tipoDeuda'] = value;
          }, ['Tipo 1', 'Tipo 2']),
          _inputText('Valor de la deuda', (value) {
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
          _inputText('Concepto', (value) {
            datos['concepto'] = value;
          }),
          _inputText('Valor', (value) {
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
          _inputText('Concepto', (value) {
            datos['concepto'] = value;
          }),
          _inputList('Periosidad', (value) {
            datos['periosidad'] = value;
          }, [
            'Diario',
            'Semanal',
            'Quincena',
            'Mensual',
            'Semestral',
            'Anual'
          ]),
          _dateInput('Fecha vencimiento', (value) {
            datos['fechaVencimiento'] = value;
          }),
          _inputList('Tipo ingreso', (value) {
            datos['tipoIngreso'] = value;
          }, ['Salario', 'Inversiones']),
          _inputText('Valor', (value) {
            datos['valor'] = value;
          }),
          _button()
        ];
        break;
      default:
        [];
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

  Widget _inputList(String name, Function callback, List<String> items) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: DropdownButtonFormField(
        focusColor: Colors.black,
        hint: Text(name),
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
        // style: ,
        isExpanded: true,
        items: items.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: callback,
      ),
    );
  }

  Widget _dateInput(String name, Function callback) {
    DateTime selectedDate = DateTime.now();

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate) setState(callback);
    }

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0)),
          alignment: Alignment.topLeft,
          child: Text(
            _fechaVencimiento != '' ? _fechaVencimiento : name,
            style: TextStyle(fontSize: 15),
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
