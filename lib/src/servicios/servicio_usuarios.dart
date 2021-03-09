import 'package:cashcontrol/src/modelos/usuario_modelo.dart';
import 'package:http/http.dart' as http;
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'dart:convert';

class UsuarioService {
  final _pref = PreferenciasUsuario();
  final _url = "https://9dfb77fdc2ce.ngrok.io";

  //adicionar nuevo usuario
  Future<Map<String, dynamic>> addUsuario(Usuario nuevoUsuario) async {
    final data = {
      "name": nuevoUsuario.nombres,
      "lastname": nuevoUsuario.apellidos,
      "email": nuevoUsuario.email,
      "phone": nuevoUsuario.telefono,
      "password": nuevoUsuario.password,
    };
    final resp = await http.post(_url + "/signup",
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('id')) {
      return {'ok': true};
    } else {
      return {'ok': false};
    }
  }

  /* //metodo login con php
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
  } */

  //metodo login
  Future<Map<String, dynamic>> login(String telefono, String password) async {
    final data = {'phone': telefono, 'password': password};
    final respuesta = await http.post(_url + "/jwt/signin",
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    Map<String, dynamic> decodeResp = json.decode(respuesta.body);
    if (decodeResp.containsKey('token')) {
      _guardarPreferencias(decodeResp);
      return {'ok': true, 'token': decodeResp['token']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']};
    }
  }

  void _guardarPreferencias(Map<String, dynamic> decodeResp) {
    _pref.recordarToken = decodeResp['token'];
    _pref.recordarNombres = decodeResp['data']['name'];
    _pref.recordarApellidos = decodeResp['data']['lastname'];
    _pref.recordarEmail = decodeResp['data']['email'];
    _pref.recordarTelefono = decodeResp['phone'];
  }

  //metodopara recordar contraseña
  Future<List> recordarClave(String telefono) async {
    return null;
  }
}
