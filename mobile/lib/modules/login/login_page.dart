import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/login/bloc/login.bloc.dart';
import 'package:pay_cutter/modules/login/widgets/login_bottom.widget.dart';
import 'package:pay_cutter/modules/login/widgets/login_top.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authenRepo: getIt.get<AuthenRepo>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) => _onListener(
          context,
          state,
        ),
        child: const _LoginView(),
      ),
    );
  }

  void _onListener(BuildContext context, LoginState state) {
    if (state is LoginSuccesful) {
      Navigator.pushReplacementNamed(
        context,
        AppRouters.core,
      );
    }
    if (state is LoginFailure) {
      ToastUlti.showError(context, 'Cannot login! An error has been occurred');
    }
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: const [
            LoginTopWidget(),
            LoginBottomWidget(),
          ],
        ),
      ),
    );
  }
}
