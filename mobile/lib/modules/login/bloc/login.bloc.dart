import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';

part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenRepo _authenRepo;
  LoginBloc({
    required AuthenRepo authenRepo,
  })  : _authenRepo = authenRepo,
        super(const LoginState.initial()) {
    on<LoginGoogle>(_loginGoogle);
  }

  Future<void> _loginGoogle(
    LoginGoogle event,
    Emitter<LoginState> emitter,
  ) async {
    try {
      bool isLogin = await _authenRepo.loginGoogle();
      if (isLogin) {
        emitter(const LoginSuccesful());
      } else {
        emitter(const LoginFailure('Login fail'));
      }
    } catch (e) {
      emitter(LoginFailure(e.toString()));
    }
  }
}
