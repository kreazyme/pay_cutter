import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:pay_cutter/modules/chat/widget/participants/item_participant.widget.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({
    super.key,
    required this.users,
  });

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Participants Page',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'There are ${users.length} user here',
                style: TextStyles.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ItemParticipantWidget(
                  participant: users[index],
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                itemCount: users.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
