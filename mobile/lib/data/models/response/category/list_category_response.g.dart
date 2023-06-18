// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCategoryResponse _$ListCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ListCategoryResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListCategoryResponseToJson(
        ListCategoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
