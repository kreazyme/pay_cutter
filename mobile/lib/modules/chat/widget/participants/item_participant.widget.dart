import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/app_avatar.widget.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

class ItemParticipantWidget extends StatelessWidget {
  const ItemParticipantWidget({
    super.key,
    required this.participant,
  });

  final UserModel participant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(
          url: participant.avatarUrl,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              participant.name,
              style: TextStyles.titleBold.copyWith(
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              participant.email,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}
