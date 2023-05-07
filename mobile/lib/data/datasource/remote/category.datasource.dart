import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/data/datasource/mock/category.mock.dart';
import 'package:pay_cutter/data/datasource/mock/user.mock.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

@LazySingleton()
class CategoryDataSource {
  const CategoryDataSource();

  Future<ParamsWrapper2<List<UserModel>, List<CategoryModel>>> fetchCategories(
      String groupID) async {
    final categories = await CategoryMock.getCategories();
    final users = UserMock.getUsers();
    return ParamsWrapper2(param1: users, param2: categories);
  }
}
