part of 'profile.bloc.dart';

class ProfileState extends Equatable {
  final HandleStatus status;

  final UserModel? user;

  const ProfileState({
    required this.status,
    this.user,
  });

  const ProfileState.initial()
      : status = HandleStatus.initial,
        user = null;

  const ProfileState.loading()
      : status = HandleStatus.loading,
        user = null;

  const ProfileState.success(UserModel this.user)
      : status = HandleStatus.success;

  const ProfileState.error()
      : status = HandleStatus.error,
        user = null;

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}

class ProfileLogouted extends ProfileState {
  const ProfileLogouted() : super.initial();
}
