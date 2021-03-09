import 'package:cashcontrol/src/modelos/usuario_modelo.dart';
import 'package:cashcontrol/src/servicios/instance.service.dart';
import 'package:http/http.dart' as http;
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'dart:convert';

class UsuarioService {
  final _pref = PreferenciasUsuario();  

  //adicionar nuevo usuario
  Future<Map<String, dynamic>> addUsuario(Usuario nuevoUsuario) async {
    Map<String, dynamic> decodeResp =
        await Intance().post("signup", data: nuevoUsuario.toJson());
    print(decodeResp);
    return {'ok': decodeResp.containsKey('id')};
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
    Map<String, dynamic> decodeResp = await Intance()
        .post("jwt/signin", data: {'phone': telefono, 'password': password});
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
