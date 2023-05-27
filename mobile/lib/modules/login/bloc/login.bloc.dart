import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/data/models/dto/user.dto.dart';
import 'package:pay_cutter/data/models/response/user_login.response.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';

part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenRepo _authenRepo;
  final UserRepo _userRepo;
  LoginBloc({
    required AuthenRepo authenRepo,
    required UserRepo userRepo,
  })  : _authenRepo = authenRepo,
        _userRepo = userRepo,
        super(const LoginState.initial()) {
    on<LoginGoogle>(_loginGoogle);
  }

  Future<void> _loginGoogle(
    LoginGoogle event,
    Emitter<LoginState> emitter,
  ) async {
    try {
      UserDTO? user = await _authenRepo.loginGoogle();
      if (user == null) {
        emitter(const LoginFailure('Login fail'));
      } else {
        debugPrint('user: ${user.googleToken}');
        final UserLoginResponse userLogin = await _userRepo.login(user);
        await _userRepo.saveUserToken(userLogin.token);
        await _userRepo.saveUser(userLogin.user);
        emitter(const LoginSuccesful());
      }
    } catch (e) {
      addError(e);
      emitter(LoginFailure(e.toString()));
    }
  }
}
