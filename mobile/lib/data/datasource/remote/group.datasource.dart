import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/endpoints.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/data/datasource/mock/group.mock.dart';
import 'package:pay_cutter/data/models/dto/group.dto.dart';
import 'package:pay_cutter/data/models/group.model.dart';

@LazySingleton()
class GroupDataSource {
  final DioHelper _dioHelper;

  const GroupDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<List<GroupModel>> getMyGroup() async {
    final response = await _dioHelper.get(
      AppEndpoints.group,
    );

    return response.body.map((e) => GroupModel.fromJson(e)).toList();
  }

  Future<GroupModel> createGroup(GroupDTO group) async {
    final response = await _dioHelper.post(
      AppEndpoints.group,
      data: group.toJson(),
    );
    return GroupModel.fromJson(response.body);
  }
}
