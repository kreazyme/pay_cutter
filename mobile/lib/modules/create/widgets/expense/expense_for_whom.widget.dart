import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/app_avatar.widget.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:pay_cutter/modules/create/bloc/create_expense/create_expense_bloc.dart';

class ExpenseForWhomWidget extends StatelessWidget {
  const ExpenseForWhomWidget({
    super.key,
    required this.users,
    required this.userSelected,
    required this.amount,
  });

  final List<UserModel> users;
  final List<int> userSelected;
  final double amount;

  double get _amountPerUser {
    if (userSelected.isEmpty) return 0;
    return amount / (userSelected.length);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('amount $amount');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const Text(
              'For Whom',
              style: TextStyles.title,
            ),
            const Spacer(),
            Text(
              _amountPerUser.toStringAsFixed(2),
              style: TextStyles.subTitle,
            )
          ],
        ),
        const SizedBox(height: 10),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (userSelected.contains(index)) {
                BlocProvider.of<CreateExpenseBloc>(context)
                    .add(CreateExpenseRemoveUser(index: index));
              } else {
                BlocProvider.of<CreateExpenseBloc>(context)
                    .add(CreateExpenseAddUser(index: index));
              }
            },
            child: _ItemUser(
              name: users[index].name,
              avatarUrl: users[index].avatarUrl,
              isSelected: userSelected.contains(index),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            height: 8,
            color: Colors.transparent,
          ),
          itemCount: users.length,
        )
      ],
    );
  }
}

class _ItemUser extends StatelessWidget {
  const _ItemUser({
    required this.name,
    required this.isSelected,
    required this.avatarUrl,
  });
  final bool isSelected;
  final String name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isSelected ? AppColors.primaryColor : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      child: Row(
        children: [
          AppAvatar(
            url: avatarUrl,
            height: 24,
            width: 24,
          ),
          const VerticalDivider(
            width: 8,
            color: Colors.transparent,
          ),
          Text(
            name,
            style: TextStyles.subTitle.copyWith(
              color: isSelected ? Colors.white : null,
            ),
          )
        ],
      ),
    );
  }
}
