import 'package:json_annotation/json_annotation.dart';

part 'group.model.g.dart';

@JsonSerializable()
class GroupModel {
  @JsonKey()
  final int id;

  @JsonKey()
  final String name;

  @JsonKey()
  final String? description;

  @JsonKey()
  final String? imageURL;

  @JsonKey()
  final DateTime updatedAt;

  const GroupModel({
    required this.id,
    required this.name,
    this.imageURL,
    this.description,
    required this.updatedAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
