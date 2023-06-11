part of 'create_expense_bloc.dart';

class CreateExpenseState extends Equatable {
  final HandleStatus? status;
  final String? error;
  final List<CategoryModel>? categories;
  final HandleStatus? categoryStatus;
  final CategoryModel? categorySelected;
  final List<UserModel>? users;
  final List<int>? userSelected;
  final String? imageUrl;
  final HandleStatus? imageStatus;
  final ExpenseModel? expense;

  const CreateExpenseState({
    this.status,
    this.error,
    this.categories,
    this.categoryStatus,
    this.categorySelected,
    this.users,
    this.userSelected,
    this.imageUrl,
    this.imageStatus,
    this.expense,
  });

  CreateExpenseState copyWith({
    HandleStatus? status,
    String? error,
    List<CategoryModel>? categories,
    HandleStatus? categoryStatus,
    CategoryModel? categorySelected,
    List<UserModel>? users,
    List<int>? userSelected,
    String? imageUrl,
    HandleStatus? imageStatus,
    ExpenseModel? expense,
  }) =>
      CreateExpenseState(
        status: status ?? this.status,
        error: error ?? this.error,
        categories: categories ?? this.categories,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        categorySelected: categorySelected ?? this.categorySelected,
        users: users ?? this.users,
        userSelected: userSelected ?? this.userSelected,
        imageUrl: imageUrl ?? this.imageUrl,
        imageStatus: imageStatus ?? this.imageStatus,
        expense: expense ?? this.expense,
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
        imageUrl,
        imageStatus,
        expense,
      ];
}

class CreateExpenseInitial extends CreateExpenseState {
  const CreateExpenseInitial({
    super.status = HandleStatus.initial,
    super.categoryStatus = HandleStatus.loading,
    super.userSelected = const [],
  });
}
