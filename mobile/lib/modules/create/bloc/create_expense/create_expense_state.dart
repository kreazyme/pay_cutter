part of 'create_expense_bloc.dart';

abstract class CreateExpenseState extends Equatable {
  final HandleStatus? status;
  final String? error;
  final List<CategoryModel>? categories;
  final HandleStatus? categoryStatus;

  const CreateExpenseState({
    this.status,
    this.error,
    this.categories,
    this.categoryStatus,
  });

  @override
  List<Object?> get props => [
        status,
        categories,
        categoryStatus,
      ];
}

class CreateExpenseInitial extends CreateExpenseState {
  const CreateExpenseInitial({
    super.status = HandleStatus.initial,
    super.categoryStatus = HandleStatus.loading,
  });
}

class CreateExpenseFailure extends CreateExpenseState {
  const CreateExpenseFailure({
    required String error,
    super.status = HandleStatus.error,
  }) : super(
          error: error,
        );
}

class CreateExpenseSuccess extends CreateExpenseState {
  const CreateExpenseSuccess({
    super.status = HandleStatus.success,
  });
}

class CreateExpenseLoading extends CreateExpenseState {
  const CreateExpenseLoading({
    super.status = HandleStatus.loading,
  });
}

class CreateExpenseCategorySuccess extends CreateExpenseState {
  const CreateExpenseCategorySuccess({
    required List<CategoryModel> categories,
    super.categoryStatus = HandleStatus.success,
  }) : super(
          categories: categories,
        );
}

class CreateExpenseCategoryFailure extends CreateExpenseState {
  const CreateExpenseCategoryFailure({
    required String error,
    super.categoryStatus = HandleStatus.error,
  }) : super(
          error: error,
        );
}
