import 'package:json_annotation/json_annotation.dart';

part 'category.model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.other() => CategoryModel(
        id: 0,
        name: 'Others',
        description: 'Others',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
