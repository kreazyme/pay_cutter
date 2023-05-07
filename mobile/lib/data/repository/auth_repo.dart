import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/firebase/firebase_auth.datasource.dart';
import 'package:pay_cutter/data/models/dto/user.dto.dart';

@lazySingleton
class AuthenRepo {
  final FirebaseAuthDataSource _authDataSource;

  const AuthenRepo({
    required FirebaseAuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  Future<bool> checkLogin() async {
    return await _authDataSource.checkLogin();
  }

  Future<UserDTO?> loginGoogle() async {
    return await _authDataSource.loginGoogle();
  }

  Future<String> loginFacebook() async {
    return await _authDataSource.loginFacebook();
  }

  Future<void> logout() async {
    return await _authDataSource.signout();
  }
}
