import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/category.datasource.dart';
import 'package:pay_cutter/data/models/category.model.dart';

@LazySingleton()
class CategoryRepository {
  final CategoryDataSource _categoryDataSource;
  const CategoryRepository({
    required CategoryDataSource categoryDataSource,
  }) : _categoryDataSource = categoryDataSource;

  Future<List<CategoryModel>> getCategories(String id) async {
    return await _categoryDataSource.fetchCategories(id);
  }
}
