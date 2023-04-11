import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
part 'splash.state.dart';
part 'splash.event.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenRepo _authenRepo;
  SplashBloc({
    required AuthenRepo userRepo,
  })  : _authenRepo = userRepo,
        super(SplashState.initial()) {
    on<SplashEvent>(_getLoginInfo);
    add(const SplashEvent());
  }

  Future<void> _getLoginInfo(
    SplashEvent event,
    Emitter<SplashState> emitter,
  ) async {
    final bool result = await _authenRepo.checkLogin();
    emitter(SplashGetSuccess(isLogin: result));
  }
}
