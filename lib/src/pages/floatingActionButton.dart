import 'package:cashcontrol/src/utils/colores.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonPage extends StatefulWidget {
  FloatingActionButtonPage({Key key}) : super(key: key);

  @override
  _FloatingActionButtonPageState createState() =>
      _FloatingActionButtonPageState();
}

class _FloatingActionButtonPageState extends State<FloatingActionButtonPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.2),
      body: Container(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            color: Colores.colorMorado.withOpacity(0.85),
          ),
          width: size.width * 0.6,
          height: size.height * 0.5,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _listTile(
                    Icons.keyboard_arrow_right, 'Agregar Gasto', true, 'Gasto'),
                _listTile(
                    Icons.keyboard_arrow_right, 'Agregar Deuda', true, 'Deuda'),
                _listTile(Icons.keyboard_arrow_right, 'Agregar Ingreso', true,
                    'Ingreso'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 55.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'X',
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff2fc9d4),
        ),
      ),
    );
  }

  Widget _listTile(icono, text, click, origen) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (click == true) {
          switch (origen) {
            case 'Gasto':
              print('Pagina Gasto');
              break;
            case 'Deuda':
              print('Pagina Deuda');
              break;
            case 'Ingreso':
              print('Pagina Ingreso');
              break;
          }
        }
      },
      child: Container(
        width: size.width * 0.6,
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Icon(
            icono,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
