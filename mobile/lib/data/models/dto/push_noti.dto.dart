import 'package:json_annotation/json_annotation.dart';

part 'push_noti.dto.g.dart';

@JsonSerializable()
class PushNotiDTO {
  final List<int> ids;
  final String sender;
  final bool isAnonymous;

  @JsonKey(name: 'group_name')
  final String groupName;

  const PushNotiDTO({
    required this.ids,
    required this.sender,
    required this.isAnonymous,
    required this.groupName,
  });

  factory PushNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$PushNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotiDTOToJson(this);
}
