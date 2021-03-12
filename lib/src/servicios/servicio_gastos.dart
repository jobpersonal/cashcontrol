import 'package:cashcontrol/src/modelos/expense_model.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GastosService {
  final _pref = PreferenciasUsuario();
  final _url = "http://ec2-18-222-191-206.us-east-2.compute.amazonaws.com";
  //adicionar nueva deuda

  Future<Map<String, dynamic>> addExpense(ExpenseModel nuevoExpense) async {
    final data = jsonEncode(
        {'concept': nuevoExpense.concept, 'amount': nuevoExpense.amount});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'bearer ' + _pref.token
    };
    final resp =
        await http.post(_url + "/api/expense", headers: headers, body: data);
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    return {'ok': decodeResp.containsKey('success')};
  }
}
