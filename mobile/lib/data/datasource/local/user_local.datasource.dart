import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/common/hive_keys.dart';

@lazySingleton
class UserLocalDatasource {
  final Box _box;
  final DioHelper _dioHelper;
  const UserLocalDatasource({
    @Named(HiveKeys.boxName) required Box box,
    required DioHelper dioHelper,
  })  : _box = box,
        _dioHelper = dioHelper;

  void saveUserToken(String token) {
    final resepose =
        _dioHelper.get('https://jsonplaceholder.typicode.com/todos/1');
    log('response: $resepose');
    _box.put(HiveKeys.userToken, token);
  }

  bool getUserToken() {
    final token = _box.get(HiveKeys.userToken);
    if (token == null) {
      return false;
    }
    return true;
  }

  String deleteToken() {
    _box.delete(HiveKeys.userToken);
    return '';
  }
}
