part of 'create_group_bloc.dart';

abstract class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupSubmit extends CreateGroupEvent {
  final String name;
  const CreateGroupSubmit({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}
