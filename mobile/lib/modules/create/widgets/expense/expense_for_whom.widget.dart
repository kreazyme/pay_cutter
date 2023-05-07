import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
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

  List<Widget> _genItems(BuildContext context) {
    return users.map(
      (e) {
        int index = users.indexOf(e);
        return GestureDetector(
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
            name: e.name,
            isSelected: userSelected.contains(index),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'For Whom',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: _genItems(context),
        ),
      ],
    );
  }
}

class _ItemUser extends StatelessWidget {
  const _ItemUser({
    required this.name,
    required this.isSelected,
  });
  final bool isSelected;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Text(name,
          style: TextStyles.subTitle.copyWith(
            color: isSelected ? Colors.white : null,
          )),
    );
  }
}
