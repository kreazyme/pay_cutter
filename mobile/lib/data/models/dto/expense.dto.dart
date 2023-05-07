import 'package:json_annotation/json_annotation.dart';

part 'expense.dto.g.dart';

@JsonSerializable()
class ExpenseDTO {
  final String name;
  final String description;
  final double amount;
  final DateTime date;

  ExpenseDTO({
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory ExpenseDTO.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDTOToJson(this);
}
