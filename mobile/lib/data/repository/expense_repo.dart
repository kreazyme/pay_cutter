import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/expense.datasource.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/models/expense.model.dart';

@LazySingleton()
class ExpenseRepository {
  final ExpenseDataSource _expenseDataSource;
  const ExpenseRepository({
    required ExpenseDataSource expenseDataSource,
  }) : _expenseDataSource = expenseDataSource;

  Future<ExpenseModel> createExpense(ExpenseDTO data) async {
    return await _expenseDataSource.createExpense(data);
  }

  Future<List<ExpenseModel>> getExpenseByGroupId(int id) async {
    return await _expenseDataSource.getExpenseByGroupID(id);
  }

  Future<void> updateExpense(String id, ExpenseDTO data) async {
    await _expenseDataSource.updateExpense(id, data);
  }

  Future<void> deleteExpense(int id) async {
    await _expenseDataSource.deleteExpense(id);
  }
}
