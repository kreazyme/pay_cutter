import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/endpoints.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/common/shared/app_enviroment.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/models/expense.model.dart';

@LazySingleton()
class ExpenseDataSource {
  final DioHelper _dioHelper;
  const ExpenseDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<ExpenseModel> createExpense(ExpenseDTO data) async {
    final response = await _dioHelper.post(
      AppEndpoints.expenses,
      data: data.toJson(),
    );
    return ExpenseModel.fromJson(response.body['data']);
  }

  Future<List<ExpenseModel>> getExpenseByGroupID(int id) async {
    final result = await _dioHelper.get(
      '${AppEndpoints.expensesByGroup}/$id',
    );
    final listExpense = result.body['data'] as List<dynamic>;
    return listExpense.map((e) => ExpenseModel.fromJson(e)).toList();
  }

  Future<void> updateExpense(String id, ExpenseDTO data) async {
    // await _dioHelper.put(
    //   '/expense/$id',
    //   data: data.toJson(),
    // );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> deleteExpense(int id) async {
    await _dioHelper.delete(
      '${AppEndpoints.expenses}/$id',
    );
  }

  Future<String> reverseGecoding(double lat, double lng) async {
    final result = await _dioHelper.get(
      '${AppEnviroment.MAP_URL}?at=$lat%2C$lng&lang=en-US&apiKey=${AppEnviroment.MAP_KEY}',
    );
    return result.body['items']['title'];
  }
}
