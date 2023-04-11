part of 'login.bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted(this.username, this.password);

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

class LoginReset extends LoginEvent {}

class LoginGoogle extends LoginEvent {}
