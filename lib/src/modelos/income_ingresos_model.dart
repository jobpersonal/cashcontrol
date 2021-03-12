import 'dart:convert';

class IncomesIngresos {
  List<IncomeIngresosModel> items = new List();
  IncomesIngresos();

  IncomesIngresos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final ingreso = new IncomeIngresosModel.fromJson(item);
      items.add(ingreso);
    }
  }
}

IncomeIngresosModel debtModelFromJson(String str) =>
    IncomeIngresosModel.fromJson(json.decode(str));
String debtModelToJson(IncomeIngresosModel data) => json.encode(data.toJson());

class IncomeIngresosModel {
  IncomeIngresosModel({
    this.concept,
    this.periodicity,
    this.incomeType,
    this.finishAt,
    this.amount,
  });

  String concept;
  String periodicity;
  String incomeType;
  String finishAt;
  String amount;

  factory IncomeIngresosModel.fromJson(Map<String, dynamic> json) =>
      IncomeIngresosModel(
        concept: json["concept"],
        periodicity: json["periodicity"],
        incomeType: json["income_type"],
        finishAt: json["finish_at"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "concept": concept,
        "periodicity": periodicity,
        "income_type": incomeType,
        "finish_at": finishAt,
        "amount": amount,
      };
}
