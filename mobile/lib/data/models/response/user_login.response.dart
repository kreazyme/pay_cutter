import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login.response.g.dart';

@JsonSerializable()
class UserLoginResponse {
  @JsonKey(name: 'data')
  final UserModel user;

  final String token;

  const UserLoginResponse({
    required this.user,
    required this.token,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}
