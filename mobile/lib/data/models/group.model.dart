import 'package:json_annotation/json_annotation.dart';

part 'group.model.g.dart';

@JsonSerializable()
class GroupModel {
  final int id;
  final String name;
  final String? imageURL;
  final DateTime updatedAt;

  const GroupModel({
    required this.id,
    required this.name,
    this.imageURL,
    required this.updatedAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
