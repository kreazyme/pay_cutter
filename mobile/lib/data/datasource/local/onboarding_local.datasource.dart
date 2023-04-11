import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pay_cutter/common/hive_keys.dart';

class OnBoardingLocalDatasource {
  final Box _box;

  const OnBoardingLocalDatasource({
    required Box box,
  }) : _box = box;

  void saveOnBoardingStatus(bool status) {
    _box.put(HiveKeys.onBoardingStatus, json.encode(status));
  }

  bool getOnBoardingStatus() {
    final status = _box.get(HiveKeys.onBoardingStatus);
    if (status == null) {
      return false;
    }
    return json.decode(status);
  }
}
