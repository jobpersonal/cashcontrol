import 'package:cashcontrol/src/widgets/logo_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [pantallaInicio(context)],
      ),
    );
  }

  Widget pantallaInicio(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          contenedorPrincipal(context),
          contenedorSecundario(context),
          Positioned(top: 90.0, left: 30.0, child: circulo()),
          Positioned(top: -40.0, right: -30.0, child: circulo()),
          Positioned(bottom: -50.0, right: -10.0, child: circulo()),
          Positioned(bottom: 120.0, right: 20.0, child: circulo()),
          Positioned(bottom: -10.0, left: -20.0, child: circulo()),
          tituloApp(),
          contenedorFooter(context)
        ],
      ),
    );
  }

  Widget circulo() {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(151, 12, 235, 0.2)),
    );
  }

  Widget tituloApp() {
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          SizedBox(height: 20, width: double.infinity),
          Text(
            'NOMY APP',
            style:
                TextStyle(fontSize: 36, color: Colors.white, letterSpacing: 3),
          ),
          SizedBox(height: 90, width: double.infinity),
          LogoPage(),
        ],
      ),
    );
  }

  Widget contenedorPrincipal(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 1,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color.fromRGBO(130, 9, 255, 1),
            Color.fromRGBO(183, 114, 255, 1)
          ])),
    );
  }

  Widget contenedorSecundario(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: double.infinity,
      margin: EdgeInsets.only(top: 200),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(255, 255, 255, 1),
                Color.fromRGBO(255, 255, 255, 1)
              ])),
    );
  }

  Widget boton(BuildContext context, String titulo, String ruta) {
    return RaisedButton(
      color: Color.fromRGBO(130, 9, 255, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pushNamed(context, ruta);
      },
      textColor: Colors.white,
      child: Text(titulo, style: TextStyle(fontSize: 16)),
    );
  }

  Widget contenedorFooter(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      margin: EdgeInsets.only(top: size.height * 0.6),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Organiza tus gastos e ingresos.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Text(
            'Realiza inversiones',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 42,
              child: boton(context, 'Registrarse', '/registrarse'),
              width: double.infinity,
            ),
          ),
          SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 42,
              child: boton(context, 'Ingresar', '/login'),
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
