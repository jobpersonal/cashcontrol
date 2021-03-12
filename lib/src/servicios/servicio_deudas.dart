import 'package:cashcontrol/src/modelos/debt_model.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeudasService {
  final _pref = PreferenciasUsuario();
  final _url = "http://ec2-18-222-191-206.us-east-2.compute.amazonaws.com";
  //adicionar nueva deuda

  Future<Map<String, dynamic>> addDebt(DebtModel nuevoDebt) async {
    final data = jsonEncode({
      'concept': nuevoDebt.concept,
      'periodicity': nuevoDebt.periodicity,
      'debt_type': nuevoDebt.debtType,
      'finish_at': nuevoDebt.finishAt,
      'debt_value': nuevoDebt.debtValue
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'bearer ' + _pref.token
    };
    final resp =
        await http.post(_url + "/api/debt", headers: headers, body: data);
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    return {'ok': decodeResp.containsKey('success')};
  }

  //lista de deudas
  Future<List> getDebt() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'bearer ' + _pref.token
    };
    final resp = await http.get(_url + "/api/debt", headers: headers);
    final decodeData = json.decode(resp.body);
    return decodeData['data'];
  }
}
