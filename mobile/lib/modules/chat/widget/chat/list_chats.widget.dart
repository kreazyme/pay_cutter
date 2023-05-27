import 'package:flutter/material.dart';
import 'package:pay_cutter/data/models/chat.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/modules/chat/widget/chat/item_chat.widget.dart';

class ListChatsWidget extends StatelessWidget {
  const ListChatsWidget({
    super.key,
    required this.chats,
    required this.group,
  });

  final List<ChatModel> chats;
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(
                  height: 50,
                );
              }
              final chat = chats[index - 1];
              return ItemChatWidget(chat: chat);
            },
            separatorBuilder: (context, index) => const Divider(
              height: 4,
              color: Colors.transparent,
            ),
            itemCount: chats.length + 1,
            reverse: true,
          ),
        ),
        const Divider(
          height: 10,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
