part of 'login.bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  const LoginState.initial() : this();

  @override
  List<Object?> get props => [];
}

class LoginSuccesful extends LoginState {
  const LoginSuccesful();

  @override
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  const LoginFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
