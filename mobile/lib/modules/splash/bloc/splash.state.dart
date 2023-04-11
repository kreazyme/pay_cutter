part of 'splash.bloc.dart';

class SplashState extends Equatable {
  final bool? isLogin;

  const SplashState({
    this.isLogin,
  });

  factory SplashState.initial() => const SplashState();

  SplashState copyWith({
    bool? isLogin,
  }) {
    return SplashState(
      isLogin: isLogin ?? this.isLogin,
    );
  }

  @override
  List<Object> get props => [];
}

class SplashGetSuccess extends SplashState {
  const SplashGetSuccess({
    required bool isLogin,
  }) : super(isLogin: isLogin);
}
