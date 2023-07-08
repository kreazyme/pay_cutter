// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseDTO _$ExpenseDTOFromJson(Map<String, dynamic> json) => ExpenseDTO(
      name: json['name'] as String,
      description: json['description'] as String? ?? 'Description is here',
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      paidBy: json['paidBy'] as int?,
      groupId: json['groupId'] as int,
      participants:
          (json['participants'] as List<dynamic>).map((e) => e as int).toList(),
      image: json['imageURL'] as String?,
      categoryId: json['categoryId'] as int?,
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExpenseDTOToJson(ExpenseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'paidBy': instance.paidBy,
      'groupId': instance.groupId,
      'participants': instance.participants,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'categoryId': instance.categoryId,
      'imageURL': instance.image,
    };
