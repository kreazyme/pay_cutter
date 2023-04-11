// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseDTO _$ExpenseDTOFromJson(Map<String, dynamic> json) => ExpenseDTO(
      name: json['name'] as String,
      description: json['description'] as String,
      amount: json['amount'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ExpenseDTOToJson(ExpenseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
      'date': instance.date,
    };
