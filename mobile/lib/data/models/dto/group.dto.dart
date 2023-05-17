import 'package:json_annotation/json_annotation.dart';

part 'group.dto.g.dart';

@JsonSerializable()
class GroupDTO {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'userId')
  final String id;

  const GroupDTO({
    required this.name,
    required this.id,
  });

  factory GroupDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDTOToJson(this);
}
