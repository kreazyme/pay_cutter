import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/home/bloc/home.bloc.dart';
import 'package:pay_cutter/modules/splash/bloc/splash.bloc.dart';
import 'package:pay_cutter/root/bloc_observer.dart';
import 'package:pay_cutter/root/flavor.dart';
import 'package:pay_cutter/root/setup.dart';
import 'package:pay_cutter/routers/app_routers.dart';

import '../data/repository/user_repo.dart';

Future<void> runMainApp(Flavor flavor) async {
  AppFlavor.flavor = flavor;
  await setupApp();
  Bloc.observer = GlobalBloc();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc(
              groupRepository: getIt.get<GroupRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Money Divider',
          navigatorKey: _navigatorKey,
          theme: ThemeData(
            primarySwatch: MaterialColor(
              AppColors.primaryColor.value,
              <int, Color>{
                50: AppColors.primaryColor,
                100: AppColors.primaryColor,
                200: AppColors.primaryColor,
                300: AppColors.primaryColor,
                400: AppColors.primaryColor,
                500: AppColors.primaryColor,
                600: AppColors.primaryColor,
                700: AppColors.primaryColor,
                800: AppColors.primaryColor,
                900: AppColors.primaryColor,
              },
            ),
            fontFamily: 'BeVietnamPro',
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouters.onGenerateRoute,
          initialRoute: AppRouters.splash,
          builder: (context, child) => BlocProvider(
            create: (context) => SplashBloc(
              userRepo: getIt.get<UserRepo>(),
              authenRepo: getIt.get<AuthenRepo>(),
            ),
            child: BlocListener<SplashBloc, SplashState>(
              listener: (_, state) async {
                if (state is SplashGetSuccess) {
                  if (state.isLogin == true) {
                    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      AppRouters.core,
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      AppRouters.login,
                      (Route<dynamic> route) => false,
                    );
                  }
                }
              },
              listenWhen: (previous, current) => previous != current,
              child: child,
            ),
          ),
        ));
  }
}
