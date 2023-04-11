import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/mock/group.mock.dart';
import 'package:pay_cutter/data/models/group.model.dart';

@LazySingleton()
class GroupDataSource {
  const GroupDataSource();

  Future<List<GroupModel>> getMyGroup() async {
    await Future.delayed(const Duration(seconds: 4));
    return GroupMock.getListGroup();
  }
}
