import 'dart:convert';

class Debts {
  List<DebtModel> items = new List();
  Debts();

  Debts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final deuda = new DebtModel.fromJson(item);
      items.add(deuda);
    }
  }
}

DebtModel debtModelFromJson(String str) => DebtModel.fromJson(json.decode(str));
String debtModelToJson(DebtModel data) => json.encode(data.toJson());

class DebtModel {
  DebtModel({
    this.concept,
    this.periodicity,
    this.debtType,
    this.finishAt,
    this.debtValue,
  });

  String concept;
  String periodicity;
  String debtType;
  String finishAt;
  String debtValue;

  factory DebtModel.fromJson(Map<String, dynamic> json) => DebtModel(
        concept: json["concept"],
        periodicity: json["periodicity"],
        debtType: json["debt_type"],
        finishAt: json["finish_at"],
        debtValue: json["debt_value"],
      );

  Map<String, dynamic> toJson() => {
        "concept": concept,
        "periodicity": periodicity,
        "debt_type": debtType,
        "finish_at": finishAt,
        "debt_value": debtValue,
      };
}
