import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

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

  @JsonKey(
    defaultValue: [],
  )
  final List<UserModel> participants;

  GroupModel({
    required this.id,
    required this.name,
    this.imageURL,
    this.description,
    required this.updatedAt,
    required this.participants,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
