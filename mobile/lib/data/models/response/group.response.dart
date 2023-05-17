import 'package:json_annotation/json_annotation.dart';
import 'package:pay_cutter/data/models/group.model.dart';

part 'group.response.g.dart';

@JsonSerializable()
class GroupResponse {
  @JsonKey(name: 'data')
  final GroupModel group;

  @JsonKey(name: 'message')
  final String message;

  const GroupResponse({
    required this.group,
    required this.message,
  });
}
