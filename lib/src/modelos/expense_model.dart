import 'dart:convert';

ExpenseModel expenseFromJson(String str) =>
    ExpenseModel.fromJson(json.decode(str));

String expenseToJson(ExpenseModel data) => json.encode(data.toJson());

//clase gastos
class ExpenseModel {
  ExpenseModel({
    this.id,
    this.concept,
    this.amount,
    this.createdAt,
  });

  int id;
  String concept;
  double amount;
  DateTime createdAt;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    id: json["id"],
    concept: json["concept"],
    amount: int.parse(json["amount"]) * 1.0,
    //amount: json["amount"].toDouble(),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "concept": concept,
    "amount": amount,
    "created_at":
        "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}
