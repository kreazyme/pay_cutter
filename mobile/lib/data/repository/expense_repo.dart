import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/expense.datasource.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';

@LazySingleton()
class ExpenseRepository {
  final ExpenseDataSource _expenseDataSource;
  const ExpenseRepository({
    required ExpenseDataSource expenseDataSource,
  }) : _expenseDataSource = expenseDataSource;

  Future<void> createExpense(ExpenseDTO data) async {
    await _expenseDataSource.createExpense(data);
  }

  Future<void> updateExpense(String id, ExpenseDTO data) async {
    await _expenseDataSource.updateExpense(id, data);
  }

  Future<void> deleteExpense(String id) async {
    await _expenseDataSource.deleteExpense(id);
  }
}
