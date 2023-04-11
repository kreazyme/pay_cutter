import 'package:json_annotation/json_annotation.dart';

part 'expense.model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final String id;
  final String name;
  final String description;
  final String amount;
  final String date;
  final String createdAt;
  final String updatedAt;

  ExpenseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
