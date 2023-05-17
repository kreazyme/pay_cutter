import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
part 'splash.state.dart';
part 'splash.event.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenRepo _authenRepo;
  final UserRepo _userRepo;
  SplashBloc({
    required AuthenRepo authenRepo,
    required UserRepo userRepo,
  })  : _authenRepo = authenRepo,
        _userRepo = userRepo,
        super(SplashState.initial()) {
    on<SplashEvent>(_getLoginInfo);
    add(const SplashEvent());
  }

  Future<void> _getLoginInfo(
    SplashEvent event,
    Emitter<SplashState> emitter,
  ) async {
    final bool result = await _authenRepo.checkLogin();
    final String token = await _userRepo.getUserToken();
    if (result == true && token != '') {
      emitter(const SplashGetSuccess(isLogin: true));
    } else {
      emitter(const SplashGetSuccess(isLogin: false));
    }
  }
}
