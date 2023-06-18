part of 'create_category_bloc.dart';

abstract class CreateCategoryState extends Equatable {
  final HandleStatus status;

  const CreateCategoryState({
    required this.status,
  });

  @override
  List<Object> get props => [];
}

class CreateCategoryInitial extends CreateCategoryState {
  const CreateCategoryInitial()
      : super(
          status: HandleStatus.initial,
        );
}

class CreateCategoryChangeStatus extends CreateCategoryState {
  const CreateCategoryChangeStatus({
    required HandleStatus status,
  }) : super(
          status: status,
        );
}

class CreateCategorySuccess extends CreateCategoryState {
  final CategoryModel category;
  const CreateCategorySuccess({
    required this.category,
  }) : super(
          status: HandleStatus.success,
        );
}
