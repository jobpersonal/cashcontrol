import 'dart:convert';

IncomeModel incomeFromJson(String str) =>
    IncomeModel.fromJson(json.decode(str));

String incomeToJson(IncomeModel data) => json.encode(data.toJson());

//class ingreso
class IncomeModel {
  IncomeModel({
    this.id,
    this.concept,
    this.amount,
    this.createdAt,
    this.typeIncome,
  });

  int id;
  String concept;
  double amount;
  DateTime createdAt;
  String typeIncome;

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        id: json["id"],
        concept: json["concept"],
        amount: json["amount"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        typeIncome: json["type_income"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "concept": concept,
        "amount": amount,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "type_income": typeIncome,
      };
}
