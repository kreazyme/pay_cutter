import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/hive_keys.dart';

@module
abstract class LocalModule {
  @Named(HiveKeys.boxName)
  @lazySingleton
  @preResolve
  Future<Box> get appBox => Hive.openBox(HiveKeys.boxName);
}
