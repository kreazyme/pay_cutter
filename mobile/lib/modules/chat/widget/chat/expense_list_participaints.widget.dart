import 'package:flutter/material.dart';
import 'package:pay_cutter/common/widgets/app_avatar.widget.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

class ExpenseListParticipants extends StatelessWidget {
  const ExpenseListParticipants({
    super.key,
    required this.participants,
  });

  final List<UserModel> participants;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 30,
      child: ListView.separated(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => AppAvatar(
          url: participants[index].avatarUrl,
          width: 20,
          height: 20,
        ),
        separatorBuilder: (context, index) => const VerticalDivider(
          width: 4,
          color: Colors.transparent,
        ),
        itemCount: participants.length,
      ),
    );
  }
}
