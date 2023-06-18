part of 'create_category_bloc.dart';

abstract class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object> get props => [];
}

class CreateCategorySubmit extends CreateCategoryEvent {
  final String name;
  final String description;
  final int groupId;
  const CreateCategorySubmit({
    required this.name,
    required this.description,
    required this.groupId,
  });

  @override
  List<Object> get props => [
        name,
        description,
        groupId,
      ];
}
