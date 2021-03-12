import 'package:cashcontrol/src/modelos/debt_model.dart';
import 'package:cashcontrol/src/modelos/income_ingresos_model.dart';
import 'package:cashcontrol/src/preferencias/preferencias.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IngresosService {
  final _pref = PreferenciasUsuario();
  final _url = "http://ec2-18-222-191-206.us-east-2.compute.amazonaws.com";
  //adicionar nueva deuda

  Future<Map<String, dynamic>> addIncome(
      IncomeIngresosModel nuevoIncome) async {
    final data = jsonEncode({
      'concept': nuevoIncome.concept,
      'periodicity': nuevoIncome.periodicity,
      'income_type': nuevoIncome.incomeType,
      'finish_at': nuevoIncome.finishAt,
      'amount': nuevoIncome.amount
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'bearer ' + _pref.token
    };
    final resp =
        await http.post(_url + "/api/income", headers: headers, body: data);
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp.containsKey('succes'));
    return {'ok': decodeResp.containsKey('succes')};
  }

  //lista de deudas
  Future<List<DebtModel>> getIncome() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'bearer ' + _pref.token
    };
    final resp = await http.get(_url + "/api/income", headers: headers);

    final decodeData = json.decode(resp.body);
    final ingresos = new Debts.fromJsonList(decodeData);
    print(ingresos);
    return ingresos.items;
  }
}
