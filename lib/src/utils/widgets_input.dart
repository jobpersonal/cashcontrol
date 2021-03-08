import 'dart:math';

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
      style: TextStyle(fontSize: 20),
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

Widget inputText2(String name, Function callback,
    {TextInputType keyboardType = TextInputType.text,
    Color colorInput = Colors.black}) {
  return Container(
    margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: TextFormField(
      keyboardType: keyboardType,
      onChanged: callback,
      style: TextStyle(color: colorInput, fontSize: 20),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(10),
        hintText: name,
        hintStyle: TextStyle(color: colorInput),
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

Widget inputText(String name, Function callback,
    {TextInputType keyboardType = TextInputType.text,
    Color colorInput = Colors.black}) {
  return Container(
    margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: TextFormField(
      keyboardType: keyboardType,
      onChanged: callback,
      style: TextStyle(color: colorInput, fontSize: 20),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        labelText: name,
        labelStyle: TextStyle(
          color: colorInput,
        ),
        filled: true,
      ),
    ),
  );
}

Widget inputDate(BuildContext context, String name, Function callback,
    [DateTime initialDate, DateTime fistDate, DateTime lastDate]) {
  String _fecha = '';

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate == null ? DateTime.now() : initialDate,
      firstDate:
          fistDate == null ? DateTime.parse("1969-07-20 20:18:04Z") : fistDate,
      lastDate:
          lastDate == null ? DateTime.parse("2269-07-20 20:18:04Z") : lastDate,
    );
    callback(picked);
    _fecha = picked.toString();
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
          _fecha != '' ? _fecha : name,
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}
