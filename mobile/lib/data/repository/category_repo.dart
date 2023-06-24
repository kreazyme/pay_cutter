import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/category.datasource.dart';
import 'package:pay_cutter/data/models/response/category/list_category_response.dart';

@LazySingleton()
class CategoryRepository {
  final CategoryDataSource _categoryDataSource;
  const CategoryRepository({
    required CategoryDataSource categoryDataSource,
  }) : _categoryDataSource = categoryDataSource;

  Future<ListCategoryResponse> getCategories(String id) async {
    return await _categoryDataSource.fetchCategories(id);
  }
}
