// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageURL: json['imageURL'] as String?,
      description: json['description'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageURL': instance.imageURL,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'participants': instance.participants,
    };
