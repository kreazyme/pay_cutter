import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/endpoints.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/data/models/dto/user.dto.dart';
import 'package:pay_cutter/data/models/response/user_login.response.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

@lazySingleton
class UserDataSource {
  final DioHelper _dioHelper;
  const UserDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<UserLoginResponse> login(UserDTO data) async {
    final response = await _dioHelper.post(
      AppEndpoints.user,
      data: data.toJson(),
    );
    return UserLoginResponse.fromJson(response.body);
  }
}
