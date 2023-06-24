import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/endpoints.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/category.dto.dart';
import 'package:pay_cutter/data/models/response/category/list_category_response.dart';

@LazySingleton()
class CategoryDataSource {
  final DioHelper _dioHelper;
  const CategoryDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<ListCategoryResponse> fetchCategories(String groupID) async {
    final response = await _dioHelper.get(
      '${AppEndpoints.category}/$groupID',
    );
    final categories = ListCategoryResponse.fromJson(response.body);
    return categories;
  }

  Future<CategoryModel> createCategory(
    String name,
    String description,
    int groupId,
  ) async {
    CategoryDTO data = CategoryDTO(
      description: description.isEmpty ? name : description,
      name: name,
    );
    final response = await _dioHelper.post(
      '${AppEndpoints.category}/$groupId',
      data: data.toJson(),
    );
    return CategoryModel.fromJson(
      response.body['data'],
    );
  }
}
