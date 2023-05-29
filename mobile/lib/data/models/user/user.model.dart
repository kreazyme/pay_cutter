import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'id')
  final int userID;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'photoUrl')
  final String? avatarUrl;

  const UserModel({
    required this.name,
    required this.userID,
    required this.email,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
