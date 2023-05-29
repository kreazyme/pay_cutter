import 'package:flutter/material.dart';
import 'package:pay_cutter/common/extensions/datetime.extension.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/app_avatar.widget.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/modules/chat/widget/chat/expense_list_participaints.widget.dart';

class ItemChatWidget extends StatelessWidget {
  const ItemChatWidget({
    super.key,
    required this.expense,
  });

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFE9E9E9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          AppAvatar(
            url: expense.createdBy.avatarUrl,
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.name,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                expense.createdAt.fullDateTime12h,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12.0,
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                expense.amount.toString(),
                style: TextStyles.titleBold.copyWith(
                  color: AppColors.textColor,
                ),
              ),
              ExpenseListParticipants(
                participants: expense.participants,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
