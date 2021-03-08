import 'package:flutter/material.dart';

class DeudaWidget extends StatefulWidget {
  @override
  _DeudaWidgettState createState() => _DeudaWidgettState();
}

class _DeudaWidgettState extends State<DeudaWidget> {
  String _concepto = '';
  String _periodisidad = '';
  String _fechaVencimiento = '';
  String _tipoDeuda = '';
  String _valorDeuda = '';

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
            _inputList('Periosidad', (value) {
              _concepto = value;
            }, [
              'Diario',
              'Semanal',
              'Quincena',
              'Mensual',
              'Semestral',
              'Anual'
            ]),
            _dateInput('Fecha vencimiento', (value) {
              _concepto = value;
            }),
            _inputList('Tipo de deuda', (value) {
              _concepto = value;
            }, ['Tipo 1', 'Tipo 2']),
            _inputText('Valor de la deuda', (value) {
              _valorDeuda = value;
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
      if (picked != null && picked != selectedDate)
        setState(() {
          _fechaVencimiento = picked.toString();
          selectedDate = picked;
        });
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
