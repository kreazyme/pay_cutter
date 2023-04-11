import 'package:flutter/material.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/modules/home/widgets/chat_group_item.widget.dart';

class ListChatGroup extends StatelessWidget {
  const ListChatGroup({
    super.key,
    required this.groups,
  });

  final List<GroupModel> groups;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return const Center(
        child: Text('No data'),
      );
    }
    return ListView.separated(
        itemBuilder: (context, index) => ChatGroupItemWidget(
              group: groups[index],
            ),
        separatorBuilder: (context, index) => const Divider(
              height: 10,
              color: Colors.transparent,
            ),
        itemCount: groups.length);
  }
}
