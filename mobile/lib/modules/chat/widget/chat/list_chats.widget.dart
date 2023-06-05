import 'package:flutter/material.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/modules/chat/widget/chat/item_chat.widget.dart';

class ListChatsWidget extends StatelessWidget {
  const ListChatsWidget({
    super.key,
    required this.expenses,
    required this.group,
  });

  final List<ExpenseModel> expenses;
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50.0, top: 10.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ItemChatWidget(expense: expense);
        },
        separatorBuilder: (context, index) => const Divider(
          height: 4,
          color: Colors.transparent,
        ),
        itemCount: expenses.length,
      ),
    );
  }
}
