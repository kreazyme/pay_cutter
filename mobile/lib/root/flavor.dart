import 'package:pay_cutter/common/enum.dart';

class AppFlavor {
  static Flavor? flavor;

  bool get isDev => flavor == Flavor.dev;

  bool get isStaging => flavor == Flavor.staging;

  bool get isProd => flavor == Flavor.prod;

  String get name => toString().split('.').last;

  String get envName => isDev
      ? '.env.dev'
      : isStaging
          ? '.env.staging'
          : '.env.prod';
}
