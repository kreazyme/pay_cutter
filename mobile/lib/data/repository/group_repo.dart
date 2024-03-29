import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/group.datasource.dart';
import 'package:pay_cutter/data/models/dto/group.dto.dart';
import 'package:pay_cutter/data/models/dto/push_noti.dto.dart';
import 'package:pay_cutter/data/models/group.model.dart';

@lazySingleton
class GroupRepository {
  final GroupDataSource _groupDataSource;
  const GroupRepository({
    required GroupDataSource groupDataSource,
  }) : _groupDataSource = groupDataSource;

  Future<List<GroupModel>> fetchGroups() async {
    return await _groupDataSource.getMyGroup();
  }

  Future<GroupModel> createGroup(GroupDTO group) async {
    return await _groupDataSource.createGroup(group);
  }

  Future<GroupModel> joinGroup(String joinCode) async {
    return await _groupDataSource.joinGroup(joinCode);
  }

  Future<GroupModel> getDetailGroup(int id) async {
    return await _groupDataSource.getDetailGroup(id);
  }

  Future<void> sendPushNoti(PushNotiDTO input) async {
    return await _groupDataSource.sendPushNoti(input);
  }
}
