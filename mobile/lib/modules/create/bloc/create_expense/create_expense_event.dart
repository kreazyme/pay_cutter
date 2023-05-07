part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class CreateExpenseStarted extends CreateExpenseEvent {
  final String groupID;
  const CreateExpenseStarted({
    required this.groupID,
  });

  @override
  List<Object> get props => [
        groupID,
      ];
}

class CreateExpenseSubmit extends CreateExpenseEvent {
  final ExpenseDTO data;
  const CreateExpenseSubmit({required this.data});

  @override
  List<Object> get props => [
        data,
      ];
}

class CreateExpenseCategorySubmit extends CreateExpenseEvent {
  final CategoryModel category;
  const CreateExpenseCategorySubmit({
    required this.category,
  });

  @override
  List<Object> get props => [
        category,
      ];
}

class CreateExpenseRemoveUser extends CreateExpenseEvent {
  final int index;
  const CreateExpenseRemoveUser({
    required this.index,
  });

  @override
  List<Object> get props => [
        index,
      ];
}

class CreateExpenseAddUser extends CreateExpenseEvent {
  final int index;
  const CreateExpenseAddUser({
    required this.index,
  });

  @override
  List<Object> get props => [
        index,
      ];
}
