import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/routers/app_routers.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatGroupItemWidget extends StatelessWidget {
  const ChatGroupItemWidget({
    super.key,
    required this.group,
  });

  final GroupModel group;
  final double _avatarLength = 50;

  void _onTap(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouters.chat,
      arguments: ParamsWrapper2<GroupModel, bool>(
        param1: group,
        param2: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: _avatarLength / 2,
        backgroundColor: _getRandomColor(),
        child: group.imageURL == null
            ? Text(
                group.name[0],
                style: TextStyles.titleBold.copyWith(
                  color: Colors.white,
                ),
              )
            : Image.network(
                group.imageURL!,
                width: _avatarLength,
                height: _avatarLength,
                fit: BoxFit.cover,
              ),
      ),
      title: Text(group.name),
      subtitle: Text(
        timeago.format(group.updatedAt),
      ),
      onTap: () => _onTap(context),
    );
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
