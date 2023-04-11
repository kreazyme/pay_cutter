part of 'profile.bloc.dart';

class ProfileState extends Equatable {
  final HandleStatus status;

  const ProfileState({
    required this.status,
  });

  const ProfileState.initial() : status = HandleStatus.initial;

  @override
  List<Object?> get props => [];
}
