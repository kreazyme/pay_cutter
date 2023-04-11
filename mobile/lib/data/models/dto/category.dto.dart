import 'package:json_annotation/json_annotation.dart';

part 'category.dto.g.dart';

@JsonSerializable()
class CategoryDTO {
  final String name;
  final String description;
  final double amount;

  CategoryDTO({
    required this.name,
    required this.description,
    required this.amount,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);
}
