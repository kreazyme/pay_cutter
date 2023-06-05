import 'package:pay_cutter/data/models/group.model.dart';

abstract class GroupMock {
  static List<GroupModel> getListGroup() => List.generate(
        12,
        (index) => GroupModel(
          id: index,
          name: '$index Name',
          updatedAt: DateTime.now(),
          participants: [],
        ),
      );

  static GroupModel getGroup() => GroupModel(
        id: 1,
        name: 'Group name',
        updatedAt: DateTime.now(),
        participants: [],
      );
}
