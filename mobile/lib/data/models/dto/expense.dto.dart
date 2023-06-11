import 'package:json_annotation/json_annotation.dart';

part 'expense.dto.g.dart';

@JsonSerializable()
class ExpenseDTO {
  final String name;

  @JsonKey()
  final String? description;
  final double amount;
  final DateTime date;
  final int? paidBy;
  final int groupId;
  final List<int> participants;

  @JsonKey(name: 'imageURL')
  final String? image;

  ExpenseDTO({
    required this.name,
    this.description = 'Description is here',
    required this.amount,
    required this.date,
    this.paidBy,
    required this.groupId,
    required this.participants,
    required this.image,
  });

  ExpenseDTO copyWith({
    String? name,
    String? description,
    double? amount,
    DateTime? date,
    int? paidBy,
    int? groupId,
    List<int>? participants,
    String? image,
  }) {
    return ExpenseDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paidBy: paidBy ?? this.paidBy,
      groupId: groupId ?? this.groupId,
      participants: participants ?? this.participants,
      image: image ?? this.image,
    );
  }

  factory ExpenseDTO.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDTOToJson(this);
}
