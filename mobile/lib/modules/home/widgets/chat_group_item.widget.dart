import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pay_cutter/common/extensions/string.extentions.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 16,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => _onTap(context),
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            CircleAvatar(
              radius: _avatarLength / 2,
              backgroundColor: _getRandomColor(),
              child: group.imageURL == null
                  ? Text(
                      group.name[0].toUpperCase(),
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
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: TextStyles.title.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  timeago.format(group.updatedAt).firstUpperCase,
                  style: TextStyles.subTitle.copyWith(
                    color: AppColors.disableColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
