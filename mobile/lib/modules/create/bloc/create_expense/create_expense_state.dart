part of 'create_expense_bloc.dart';

class CreateExpenseState extends Equatable {
  final HandleStatus? status;
  final String? error;
  final List<CategoryModel>? categories;
  final HandleStatus? categoryStatus;
  final CategoryModel? categorySelected;
  final List<UserModel>? users;
  final List<int>? userSelected;

  const CreateExpenseState({
    this.status,
    this.error,
    this.categories,
    this.categoryStatus,
    this.categorySelected,
    this.users,
    this.userSelected,
  });

  CreateExpenseState copyWith({
    HandleStatus? status,
    String? error,
    List<CategoryModel>? categories,
    HandleStatus? categoryStatus,
    CategoryModel? categorySelected,
    List<UserModel>? users,
    List<int>? userSelected,
  }) =>
      CreateExpenseState(
        status: status ?? this.status,
        error: error ?? this.error,
        categories: categories ?? this.categories,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        categorySelected: categorySelected ?? this.categorySelected,
        users: users ?? this.users,
        userSelected: userSelected ?? this.userSelected,
      );

  @override
  List<Object?> get props => [
        status,
        categories,
        categoryStatus,
        categorySelected,
        error,
        users,
        userSelected,
      ];
}

class CreateExpenseInitial extends CreateExpenseState {
  const CreateExpenseInitial({
    super.status = HandleStatus.initial,
    super.categoryStatus = HandleStatus.loading,
    super.userSelected = const [],
  });
}
