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
  final double? amount;
  final LatLng? location;
  final String? address;
  final int? expenseAmount;

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
    this.amount,
    this.location,
    this.expenseAmount,
    this.address,
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
    double? amount,
    LatLng? location,
    int? expenseAmount,
    String? address,
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
        amount: amount ?? this.amount,
        location: location ?? this.location,
        expenseAmount: expenseAmount ?? this.expenseAmount,
        address: address ?? this.address,
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
        amount,
        location,
        expenseAmount,
      ];
}

class CreateExpenseInitial extends CreateExpenseState {
  const CreateExpenseInitial({
    super.status = HandleStatus.initial,
    super.categoryStatus = HandleStatus.loading,
    super.userSelected = const [],
  });
}
