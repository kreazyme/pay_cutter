// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      name: json['name'] as String,
      email: json['email'] as String,
      avatarURL: json['avatarURL'] as String,
      googleToken: json['googleToken'] as String,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatarURL': instance.avatarURL,
      'googleToken': instance.googleToken,
    };
