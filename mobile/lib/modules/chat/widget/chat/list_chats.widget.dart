import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/data/models/chat.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/modules/chat/widget/chat/chat_input.widget.dart';
import 'package:pay_cutter/modules/chat/widget/chat/item_chat.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

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
              final chat = chats[index];
              return ItemChatWidget(chat: chat);
            },
            separatorBuilder: (context, index) => const Divider(
              height: 4,
              color: Colors.transparent,
            ),
            itemCount: chats.length,
            reverse: true,
          ),
        ),
        const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouters.createExpense,
                    arguments: group.id,
                  ),
                  child: Icon(
                    Icons.attach_money_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              ChatInputWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
