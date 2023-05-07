import 'package:json_annotation/json_annotation.dart';

part 'group.dto.g.dart';

@JsonSerializable()
class GroupDTO {
  String name;

  GroupDTO({
    required this.name,
  });

  factory GroupDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDTOToJson(this);
}
