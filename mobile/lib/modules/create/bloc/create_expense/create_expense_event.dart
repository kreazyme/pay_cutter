part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class CreateExpenseStarted extends CreateExpenseEvent {
  const CreateExpenseStarted();
}

class CreateExpenseSubmit extends CreateExpenseEvent {
  final ExpenseDTO data;
  const CreateExpenseSubmit({required this.data});

  @override
  List<Object> get props => [
        data,
      ];
}
