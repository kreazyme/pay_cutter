import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpenseRepository _expenseRepository;
  CreateExpenseBloc({
    required ExpenseRepository expenseRepository,
  })  : _expenseRepository = expenseRepository,
        super(const CreateExpenseInitial()) {
    on<CreateExpenseSubmit>(_createExpense);
  }

  Future<void> _createExpense(
    CreateExpenseSubmit event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      emittter(const CreateExpenseLoading());
      await _expenseRepository.createExpense(event.data);
      emittter(const CreateExpenseSuccess());
    } catch (e) {
      emittter(CreateExpenseFailure(error: e.toString()));
    }
  }
}
