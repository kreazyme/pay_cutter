part of 'home.bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeAddGroup extends HomeEvent {
  final GroupModel group;
  const HomeAddGroup({
    required this.group,
  });

  @override
  List<Object?> get props => [group];
}
