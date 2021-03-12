import 'package:cashcontrol/src/modelos/expense_model.dart';
import 'package:cashcontrol/src/servicios/servicio_gastos.dart';
import 'package:flutter/material.dart';

class EgresosWidget extends StatefulWidget {
  @override
  _EgresosWidgetState createState() => _EgresosWidgetState();
}

class _EgresosWidgetState extends State<EgresosWidget> {
  ExpenseModel _expenseModel = ExpenseModel();
  final _expenseService = GastosService();
  String _concepto = '';
  String _valor = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.3,
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
              SizedBox(
                height: 40,
              ),
              Text(
                'Agregar Gasto',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              _inputText('Concepto', (value) {
                _expenseModel.concept = value;
              }),
              _inputText('Valor', (value) {
                _expenseModel.amount = value;
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

  Widget _button() {
    return FlatButton(
        onPressed: () async {
          final res = await _expenseService.addExpense(_expenseModel);
          print(res);
          if (res['ok']) {
            _mostrarAlerta(context, "Se registro gasto", 'R');
            // Navigator.pushReplacementNamed(context, '/deuda');
          } else {
            _mostrarAlerta(context, "No se registro gasto", 'E');
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
