import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/data/models/dto/category.dto.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';

@LazySingleton()
class ExpenseDataSource {
  final DioHelper _dioHelper;
  const ExpenseDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<void> createExpense(ExpenseDTO data) async {
    // await _dioHelper.post(
    //   '/expense',
    //   data: data.toJson(),
    // );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> updateExpense(String id, ExpenseDTO data) async {
    // await _dioHelper.put(
    //   '/expense/$id',
    //   data: data.toJson(),
    // );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> deleteExpense(String id) async {
    // await _dioHelper.delete(
    //   '/expense/$id',
    // );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> createCategory(CategoryDTO data) async {
    // await _dioHelper.post(
    //   '/category',
    //   data: data.toJson(),
    // );
    await Future.delayed(const Duration(seconds: 2));
  }
}
