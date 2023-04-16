import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/mock/category.mock.dart';
import 'package:pay_cutter/data/models/category.model.dart';

@LazySingleton()
class CategoryDataSource {
  const CategoryDataSource();

  Future<List<CategoryModel>> fetchCategories(String groupID) async {
    return await CategoryMock.getCategories();
  }
}
