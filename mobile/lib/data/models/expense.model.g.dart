// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      amount: json['amount'] as String,
      date: json['date'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
      'date': instance.date,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
