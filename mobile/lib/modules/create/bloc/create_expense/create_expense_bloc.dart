import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/repository/category_repo.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpenseRepository _expenseRepository;
  final CategoryRepository _categoryRepository;
  CreateExpenseBloc({
    required ExpenseRepository expenseRepository,
    required CategoryRepository categoryRepository,
  })  : _expenseRepository = expenseRepository,
        _categoryRepository = categoryRepository,
        super(const CreateExpenseInitial()) {
    on<CreateExpenseSubmit>(_createExpense);
    on<CreateExpenseCategorySubmit>(_categorySelect);
    on<CreateExpenseStarted>(_inital);
  }

  Future<void> _inital(
    CreateExpenseStarted event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    try {
      emittter(const CreateExpenseLoading());
      final categories = await _categoryRepository.getCategories(
        event.groupID,
      );
      emittter(CreateExpenseCategorySuccess(categories: categories));
    } catch (e) {
      emittter(CreateExpenseFailure(error: e.toString()));
    }
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

  Future<void> _categorySelect(
    CreateExpenseCategorySubmit event,
    Emitter<CreateExpenseState> emittter,
  ) async {
    emittter(
      CreateExpenseCategorySelected(
        categorySelected: event.category,
        categories: state.categories ?? [],
      ),
    );
  }
}
