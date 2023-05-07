import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/local/user_local.datasource.dart';
import 'package:pay_cutter/data/datasource/remote/user.datasource.dart';
import 'package:pay_cutter/data/models/dto/user.dto.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

@lazySingleton
class UserRepo {
  final UserLocalDatasource _userLocalDatasource;
  final UserDataSource _userDataSource;

  const UserRepo({
    required UserLocalDatasource userLocalDatasource,
    required UserDataSource userDataSource,
  })  : _userLocalDatasource = userLocalDatasource,
        _userDataSource = userDataSource;

  void saveUserToken(String token) {
    _userLocalDatasource.saveUserToken(token);
  }

  Future<bool> getUserToken() async {
    return await _userLocalDatasource.getUserToken();
  }

  Future<UserModel> getUser() async {
    return await _userLocalDatasource.getUser();
  }

  Future<void> saveUser(UserModel user) async {
    await _userLocalDatasource.saveUser(user);
  }

  Future<void> deleteToken() async {
    await _userLocalDatasource.deleteToken();
  }

  Future<UserModel> login(UserDTO data) async {
    return await _userDataSource.login(data);
  }
}
