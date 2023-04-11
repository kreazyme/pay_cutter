// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      userID: json['id'] as int,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.userID,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
    };
