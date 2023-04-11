import 'package:json_annotation/json_annotation.dart';

part 'chat.model.g.dart';

@JsonSerializable()
class ChatModel {
  final String id;
  final String content;
  final String senderId;
  final DateTime createdAt;

  const ChatModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
