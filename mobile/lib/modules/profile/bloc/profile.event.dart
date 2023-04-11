part of 'profile.bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileSuccess extends ProfileEvent {}

class ProfileStarted extends ProfileEvent {}
