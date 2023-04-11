part of 'home.bloc.dart';

class HomeState extends Equatable {
  final HandleStatus status;
  final List<GroupModel> groups;
  final String? error;

  const HomeState({
    required this.status,
    required this.groups,
    this.error,
  });

  const HomeState.loading()
      : this(
          status: HandleStatus.loading,
          groups: const [],
        );

  const HomeState.success(List<GroupModel> groups)
      : this(
          status: HandleStatus.success,
          groups: groups,
        );

  const HomeState.error(String error)
      : this(
          status: HandleStatus.error,
          groups: const [],
          error: error,
        );
  @override
  List<Object?> get props => [
        status,
        groups,
        error,
      ];
}
