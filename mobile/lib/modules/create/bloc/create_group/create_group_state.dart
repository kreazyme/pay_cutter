part of 'create_group_bloc.dart';

abstract class CreateGroupState extends Equatable {
  final HandleStatus status;
  final GroupModel? group;
  final String? error;
  const CreateGroupState({
    required this.status,
    this.group,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        group,
        error,
      ];
}

class CreateGroupInitial extends CreateGroupState {
  const CreateGroupInitial()
      : super(
          status: HandleStatus.initial,
        );
  @override
  List<Object?> get props => [
        status,
      ];
}

class CreateGroupSuccess extends CreateGroupState {
  const CreateGroupSuccess({
    required GroupModel group,
  }) : super(
          status: HandleStatus.success,
          group: group,
        );
  @override
  List<Object?> get props => [
        group,
        status,
      ];
}

class CreateGroupFailure extends CreateGroupState {
  const CreateGroupFailure({
    required error,
  }) : super(
          status: HandleStatus.error,
          error: error,
        );
  @override
  List<Object?> get props => [
        error,
        status,
      ];
}

class CreateGroupLoading extends CreateGroupState {
  const CreateGroupLoading() : super(status: HandleStatus.loading);
  @override
  List<Object?> get props => [
        status,
      ];
}
