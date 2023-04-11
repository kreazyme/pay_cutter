import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/local/user_local.datasource.dart';

@lazySingleton
class UserRepo {
  final UserLocalDatasource _userLocalDatasource;

  const UserRepo({
    required UserLocalDatasource userLocalDatasource,
  }) : _userLocalDatasource = userLocalDatasource;

  void saveUserToken(String token) {
    _userLocalDatasource.saveUserToken(token);
  }

  bool getUserToken() {
    return _userLocalDatasource.getUserToken();
  }
}
