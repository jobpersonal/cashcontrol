import 'package:cashcontrol/src/modelos/usuario_modelo.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:cashcontrol/src/servicios/servicio_usuarios.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrarsePage extends StatefulWidget {
  @override
  _RegistrarsePageState createState() => _RegistrarsePageState();
}

final _formKey = GlobalKey<FormState>();

class _RegistrarsePageState extends State<RegistrarsePage> {
  bool _passwordVisible = false;
  TextEditingController _nombresController;
  TextEditingController _apellidosController;
  TextEditingController _telefonoController;
  TextEditingController _emailController;
  TextEditingController _claveController;
  Usuario nuevoUsuario = Usuario();
  final usuarioService = UsuarioService();
  final _prefs = PreferenciasUsuario();

  @override
  void initState() {
    _passwordVisible = false;
    _nombresController = TextEditingController();
    _apellidosController = TextEditingController();
    _telefonoController = TextEditingController();
    _emailController = TextEditingController();
    _claveController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          _crearFondo(context),
          _form(context),
        ],
      ),
    ));
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 60.0,
            ),
          ),
          contenedorInput(context)
        ],
      ),
    );
  }

  Widget contenedorInput(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.25),
      padding: EdgeInsets.symmetric(vertical: 10.0),
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              _avatar(context),
              Text('Registra tus datos',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              crearInput('Nombres', Icons.person, TextInputType.text,
                  _nombresController),
              SizedBox(height: 15.0),
              crearInput('Apellidos', Icons.people_alt, TextInputType.text,
                  _apellidosController),
              SizedBox(height: 15.0),
              crearInput('Telefono', Icons.phone, TextInputType.phone,
                  _telefonoController),
              SizedBox(height: 20.0),
              crearInput('Email', Icons.email, TextInputType.emailAddress,
                  _emailController),
              SizedBox(height: 20.0),
              _crearPassword(),
              SizedBox(height: 20.0),
              _crearBoton()
            ],
          ),
        ),
      ),
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
                  Text('Se registro usuario con éxito!!'),
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

  Widget crearInput(String titulo, IconData icono, TextInputType tipo,
      TextEditingController campo) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(127, 3, 255, 0.9),
        Color.fromRGBO(161, 70, 255, 0.6),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: campo,
        keyboardType: tipo,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(161, 70, 255, 0.6)),
          ),
          icon: Icon(icono, color: Colors.white),
          hintText: titulo,
          labelText: titulo,
          labelStyle: TextStyle(color: Colors.white),
        ),
        onChanged: (value) {
          if (titulo == 'Nombres') {
            nuevoUsuario.nombres = value;
          }
          if (titulo == 'Apellidos') {
            nuevoUsuario.apellidos = value;
          }
          if (titulo == 'Telefono') {
            nuevoUsuario.telefono = value;
          }
          if (titulo == 'Email') {
            nuevoUsuario.email = value;
          }
        },
        validator: (value) {
          if (titulo == 'Nombres' || titulo == 'Apellidos') {
            if (value.length < 3) {
              return 'Minimo 3 carácteres';
            } else {
              return null;
            }
          }
          if (titulo == 'Telefono') {
            if (value.length < 10 || value.length > 10) {
              return 'Son 10 carácteres';
            } else {
              return null;
            }
          }
          if (titulo == 'Email') {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = new RegExp(pattern);

            if (regExp.hasMatch(value)) {
              print('Correcto');
            } else {
              return 'Email no es correcto';
            }
          }
        },
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    return Center(
        child: RaisedButton.icon(
      label: Text('Cargar foto'),
      icon: Icon(Icons.camera_alt),
      onPressed: () {
        _showChoiceDialog(context);
      },
    ));
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  _openGallery(BuildContext context) async {
    final imagen = ImagePicker();
    final archivo = await imagen.getImage(source: ImageSource.gallery);
    print(archivo.path);
    /*resp = await _servicio.subirImagen(archivo);*/

    setState(() {
      _prefs.recordarAvatar = archivo.path;
      print('ruta: ${_prefs.avatar}');
    });
  }

  _openCamera(BuildContext context) async {
    final imagen = ImagePicker();
    final archivo = await imagen.getImage(source: ImageSource.camera);
    print(archivo.path);
    /*  resp = await _servicio.subirImagen(archivo);
    _prefs.recordarLinkFoto = resp;
    print('ruta: ${_prefs.linkFoto}'); */
    setState(() {});
  }

  Widget _mostrarImagen() {
    final size = MediaQuery.of(context).size;
    // resp = _prefs.linkFoto;
    return Center(
        child: Image(
      image: NetworkImage(
          'https://www.latercera.com/resizer/Am6Tr2ws8JnL4CHLfU_Humpr56Q=/900x600/smart/arc-anglerfish-arc2-prod-copesa.s3.amazonaws.com/public/XMJRWZH5N5CBXPL67NAKBGXFNI.jpg'),
    ));
  }

  Widget _crearPassword() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(127, 3, 255, 0.9),
          Color.fromRGBO(161, 70, 255, 0.6),
        ])),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: _claveController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
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
          ),
          onChanged: (value) {
            nuevoUsuario.password = value;
          },
          validator: (value) {
            if (value.length < 8) {
              return 'Minimo 8 carácteres';
            } else {
              return null;
            }
          },
        ));
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Registrar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: Color.fromRGBO(130, 9, 255, 1),
        textColor: Colors.white,
        onPressed: () {
          if (!_formKey.currentState.validate()) return;
          nuevoUsuario.avatar = "no";
          usuarioService.addUsuario(nuevoUsuario);
          alerta(context);
        });
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoApp = Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.white,
            Colors.white,
          ])),
    );

    return Stack(
      children: <Widget>[
        fondoApp,
        Positioned(top: 90.0, left: 30.0, child: circulo()),
        Positioned(top: -40.0, right: -30.0, child: circulo()),
        Positioned(bottom: -50.0, right: -10.0, child: circulo()),
        Positioned(bottom: 120.0, right: 20.0, child: circulo()),
        Positioned(bottom: -50.0, left: -20.0, child: circulo()),
        Container(
          padding: EdgeInsets.only(top: 0.0),
          child: Column(
            children: <Widget>[_mostrarImagen()],
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
          color: Color.fromRGBO(151, 12, 235, 0.1)),
    );
  }
}
