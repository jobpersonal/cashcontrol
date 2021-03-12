import 'package:cashcontrol/src/modelos/usuario_modelo.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioService {
  final _pref = PreferenciasUsuario();
  final _url = "http://ec2-18-222-191-206.us-east-2.compute.amazonaws.com";
  //adicionar nuevo usuario
  Future<Map<String, dynamic>> addUsuario(Usuario nuevoUsuario) async {
    final resp = await http.post(_url + "/signup",
        body: json.encode(nuevoUsuario),
        headers: {'Content-Type': 'application/json'});

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    //_guardarPreferenciasRegistro(decodeResp);
    return {'ok': true};
  }

  //metodo login
  Future<Map<String, dynamic>> login(String telefono, String password) async {
    final data = {'phone': telefono, 'password': password};
    final respuesta = await http.post(_url + "/jwt/signin",
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    Map<String, dynamic> decodeResp = json.decode(respuesta.body);
    print(decodeResp);
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
