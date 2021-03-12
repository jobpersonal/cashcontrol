import 'package:cashcontrol/src/modelos/expense_model.dart';
import 'package:cashcontrol/src/servicios/instance.service.dart';

class TransationsService {

  final _httpManager = Intance();

  Future<List<ExpenseModel>> getTransations({DateTime initdate, DateTime finalDate}) async {
    final response = await this._httpManager.geT('api/transactions');

    final List<dynamic> data = response['data'];
    
    if (data.length > 0) {
      List<ExpenseModel> transations = [];

      data.forEach((element) {
        Map<String, dynamic> _data = (element['income'] != null)
          ? element['income']
          : element['expense'];

        final _transation = ExpenseModel.fromJson(_data);

        transations.add(_transation);
      });

      return transations;
    } else {
      return [];
    }

    
  }
}