import 'package:json_annotation/json_annotation.dart';

part 'user.dto.g.dart';

@JsonSerializable()
class UserDTO {
  final String name;
  final String email;
  final String photoUrl;
  final String googleToken;

  const UserDTO({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.googleToken,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
