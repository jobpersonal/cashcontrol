import 'package:flutter/material.dart';

Widget a() {
  return Text('A');
}

Widget inputList(String name, Function callback, List<String> items) {
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

Widget inputText(String name, Function callback) {
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

Widget dateInput(BuildContext context, String name, Function callback) {
  DateTime selectedDate = DateTime.now();
  String _fecha = '';

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) callback;
    if (picked != null && picked != selectedDate) callback;
  }

  return GestureDetector(
    onTap: () => _selectDate(context),
    child: Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1.0)),
        alignment: Alignment.topLeft,
        child: Text(
          // '',
          _fecha != '' ? _fecha : name,
          style: TextStyle(fontSize: 15),
        ),
      ),
    ),
  );
}
