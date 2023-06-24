// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_noti.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotiDTO _$PushNotiDTOFromJson(Map<String, dynamic> json) => PushNotiDTO(
      ids: (json['ids'] as List<dynamic>).map((e) => e as int).toList(),
      sender: json['sender'] as String,
      isAnonymous: json['isAnonymous'] as bool,
      groupName: json['group_name'] as String,
    );

Map<String, dynamic> _$PushNotiDTOToJson(PushNotiDTO instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'sender': instance.sender,
      'isAnonymous': instance.isAnonymous,
      'group_name': instance.groupName,
    };
