import 'package:cashcontrol/src/bloc/bloc_login.dart';
import 'package:cashcontrol/src/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:cashcontrol/src/servicios/servicio_usuarios.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioService = UsuarioService();

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 45.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                _crearTelefono(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc, context)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/recordar');
            },
            child: Text(
              '¿Olvido la contraseña?',
              style: TextStyle(
                  color: Color.fromRGBO(130, 9, 255, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearTelefono(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.telefonoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(127, 3, 255, 0.9),
            Color.fromRGBO(161, 70, 255, 0.6),
          ])),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
                ),
                border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
                ),
                icon: Icon(Icons.phone, color: Colors.white),
                hintText: 'Número telefónico',
                labelText: 'Número telefónico',
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.white),
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeTelefono,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(127, 3, 255, 0.9),
            Color.fromRGBO(161, 70, 255, 0.6),
          ])),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
              ),
              border: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              icon: Icon(Icons.lock_outline, color: Colors.white),
              labelText: 'Contraseña',
              labelStyle: TextStyle(color: Colors.white),
              errorStyle: TextStyle(color: Colors.white),
              // counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Color.fromRGBO(130, 9, 255, 1),
            textColor: Colors.white,
            onPressed: () {
              _login(bloc, context);
            });
      },
    );
  }

  void alerta(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              title: Text(
                "Información",
                style: TextStyle(color: Colors.purple[800]),
              ),
              backgroundColor: Colors.white,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sus datos son incorrectos!!'),
                ],
              ),
              actions: [
                FlatButton(
                    child:
                        Text("Aceptar", style: TextStyle(color: Colors.white)),
                    color: Colors.purple[900],
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoApp = Container(
      height: size.height * 0.4,
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

    return Stack(
      children: <Widget>[
        fondoApp,
        Positioned(top: 90.0, left: 30.0, child: circulo()),
        Positioned(top: -40.0, right: -30.0, child: circulo()),
        Positioned(bottom: -50.0, right: -10.0, child: circulo()),
        Positioned(bottom: 120.0, right: 20.0, child: circulo()),
        Positioned(bottom: -10.0, left: -20.0, child: circulo()),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('NOMY APP',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
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

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioService.login(bloc.telefono, bloc.password);
    print(info);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      _mostrarAlerta(context, "Sus datos son incorrectos");
    }
  }

  void _mostrarAlerta(BuildContext context, String mensaje) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Informacion de advertencia'),
            content: Text(mensaje),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
