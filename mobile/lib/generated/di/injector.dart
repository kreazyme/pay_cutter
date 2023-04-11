import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initGetIt',
  asExtension: false,
)
Future<void> configureDependencies() async => await initGetIt(getIt);
