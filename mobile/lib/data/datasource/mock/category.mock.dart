import 'package:pay_cutter/data/models/category.model.dart';

abstract class CategoryMock {
  static Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      10,
      (index) => CategoryModel(
        id: index,
        name: 'Category num $index',
        description: 'description',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  static Future<CategoryModel> getCategory() async {
    await Future.delayed(const Duration(seconds: 1));
    return CategoryModel(
      id: 1,
      name: 'Category num 1',
      description: 'description',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
