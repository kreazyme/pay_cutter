import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBloc extends BlocObserver {
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log(
      'onClose: ${bloc.runtimeType}',
    );
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      'onCreate: ${bloc.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError: ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      'onEvent: ${bloc.runtimeType} ====> $event',
    );
  }
}
