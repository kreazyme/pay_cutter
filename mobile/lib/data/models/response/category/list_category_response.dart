import 'package:json_annotation/json_annotation.dart';
import 'package:pay_cutter/data/models/category.model.dart';

part 'list_category_response.g.dart';

@JsonSerializable()
class ListCategoryResponse {
  final List<CategoryModel> data;

  const ListCategoryResponse({
    required this.data,
  });

  factory ListCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCategoryResponseToJson(this);
}
