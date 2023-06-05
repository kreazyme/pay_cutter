import 'package:json_annotation/json_annotation.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

part 'expense.model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final int id;
  final String name;
  final String? description;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel createdBy;
  final List<UserModel> participants;

  ExpenseModel({
    required this.id,
    required this.name,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.participants,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
