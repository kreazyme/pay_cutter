import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/group.datasource.dart';
import 'package:pay_cutter/data/models/dto/group.dto.dart';
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
}
