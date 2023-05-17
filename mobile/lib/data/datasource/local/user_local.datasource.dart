import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/common/hive_keys.dart';
import 'package:pay_cutter/data/datasource/mock/user.mock.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

@lazySingleton
class UserLocalDatasource {
  final Box _box;
  final DioHelper _dioHelper;
  const UserLocalDatasource({
    @Named(HiveKeys.boxName) required Box box,
    required DioHelper dioHelper,
  })  : _box = box,
        _dioHelper = dioHelper;

  Future<void> saveUserToken(String token) async {
    await _box.put(HiveKeys.userToken, token);
  }

  Future<String> getUserToken() async {
    try {
      final token = await _box.get(HiveKeys.userToken);
      return token;
    } catch (e) {
      return '';
    }
  }

  Future<String> deleteToken() async {
    await _box.delete(HiveKeys.userToken);
    return '';
  }

  Future<UserModel> getUser() async {
    final user = await _box.get(HiveKeys.user);
    return UserModel.fromJson(user);
  }

  Future<void> saveUser(UserModel user) async {
    await _box.put(HiveKeys.user, user.toJson());
  }
}
