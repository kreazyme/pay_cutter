part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class CreateExpenseStarted extends CreateExpenseEvent {
  final GroupModel groupModel;
  const CreateExpenseStarted({
    required this.groupModel,
  });

  @override
  List<Object> get props => [
        groupModel,
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

class CreateExpenseUploadFile extends CreateExpenseEvent {
  final int groupId;
  const CreateExpenseUploadFile({
    required this.groupId,
  });

  @override
  List<Object> get props => [
        groupId,
      ];
}

class CreateExpenseTakePicture extends CreateExpenseEvent {
  final int groupId;
  const CreateExpenseTakePicture({
    required this.groupId,
  });

  @override
  List<Object> get props => [
        groupId,
      ];
}

class CreateExpenseChangeAmount extends CreateExpenseEvent {
  final double amount;
  const CreateExpenseChangeAmount({
    required this.amount,
  });

  @override
  List<Object> get props => [
        amount,
      ];
}

class CreateExpenseChangeLocation extends CreateExpenseEvent {
  final LatLng location;
  const CreateExpenseChangeLocation({
    required this.location,
  });

  @override
  List<Object> get props => [
        location,
      ];
}
