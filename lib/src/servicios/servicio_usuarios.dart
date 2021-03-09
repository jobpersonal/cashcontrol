import 'package:cashcontrol/src/modelos/usuario_modelo.dart';
import 'package:http/http.dart' as http;
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'dart:convert';

class UsuarioService {
  String _url = "http://192.168.0.19/nomyApp/";
  final _pref = PreferenciasUsuario();

  void addUsuario(Usuario nuevoUsuario) async {
    final resp = await http.post(_url + "usuarios/addUsuario.php", body: {
      "nombres": nuevoUsuario.nombres,
      "apellidos": nuevoUsuario.apellidos,
      "telefono": nuevoUsuario.telefono,
      "email": nuevoUsuario.email,
      "password": nuevoUsuario.password,
    });
  }

  //metodo login
  Future<List> login(String telefono, String password) async {
    final data = {'telefono': telefono, 'password': password};
    final respuesta = await http.post(_url + "usuarios/login.php", body: data);
    var datauser = json.decode(respuesta.body);
    _pref.recordarNombres = datauser[0]['nombres'];
    _pref.recordarApellidos = datauser[0]['apellidos'];
    _pref.recordarEmail = datauser[0]['email'];
    _pref.recordarTelefono = datauser[0]['telefono'];
    _pref.recordarTap = 0;
    return datauser;
  }

  //metodopara recordar contraseña
  Future<List> recordarClave(String telefono) async {
    return null;
    /* final data = {'telefono': telefono};
    final respuesta =
        await http.post(_url + "usuarios/recordar.php", body: data);

    var datauser = json.decode(respuesta.body);

    if (datauser.length > 0) {
      print('Ingreso correcto: $datauser');
    }
    return datauser; */
  }

  Future<String> agregarDatos(Map data) async {
    final respuesta = await http.post(_url + 'usuarios/', body: data);
  }
}
