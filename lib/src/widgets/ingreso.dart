import 'package:cashcontrol/src/modelos/income_ingresos_model.dart';
import 'package:cashcontrol/src/servicios/servicio_ingresos.dart';
import 'package:flutter/material.dart';

class IngresosWidget extends StatefulWidget {
  @override
  _IngresosWidgettState createState() => _IngresosWidgettState();
}

class _IngresosWidgettState extends State<IngresosWidget> {
  IncomeIngresosModel _incomeModel = IncomeIngresosModel();
  final _incomeService = IngresosService();
  String _concepto = '';
  String _periodisidad = '';
  String _fechaVencimiento = '';
  String _tipoDeuda = '';
  String _valorDeuda = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        height: size.height * 0.3,
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
              SizedBox(
                height: 40,
              ),
              Text(
                'Agregar Ingreso',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              _inputText('Concepto', (value) {
                _incomeModel.concept = value;
              }),
              _inputList('Periosidad', (value) {
                _incomeModel.periodicity = value;
              }, ['Dia', 'Sema', 'Quin', 'Mens', 'Seme', 'Anual']),
              _dateInput('Fecha vencimiento', (value) {
                _fechaVencimiento = value;
              }),
              _inputList('Tipo de ingreso', (value) {
                _incomeModel.incomeType = value;
              }, ['Arrendo', 'Transporte', 'Alimentación', 'Prestamo']),
              _inputText('Valor del ingreso', (value) {
                _incomeModel.amount = value;
              }),
              _button()
            ],
          ),
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
        onPressed: () async {
          _incomeModel.finishAt = "2-20-2022";
          final res = await _incomeService.addIncome(_incomeModel);
          print(res);
          if (res['ok']) {
            _mostrarAlerta(context, "Se registro ingreso", 'R');
            // Navigator.pushReplacementNamed(context, '/deuda');
          } else {
            _mostrarAlerta(context, "No se registro ingreso", 'E');
          }
        },
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

  void _mostrarAlerta(BuildContext context, String mensaje, String tipo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Advertencia'),
            content: Text(mensaje),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (tipo == "E") {
                    Navigator.of(context).pop();
                  }
                  if (tipo == "R") {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }
                },
              )
            ],
          );
        });
  }
}
