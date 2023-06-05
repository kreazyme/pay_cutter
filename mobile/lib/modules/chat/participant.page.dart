import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('ParticipantsPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) => ItemParticipantWidget(
            participant: users[index],
          ),
          separatorBuilder: (context, index) => const Divider(
            height: 4,
            color: Colors.transparent,
          ),
          itemCount: users.length,
        ),
      ),
    );
  }
}
