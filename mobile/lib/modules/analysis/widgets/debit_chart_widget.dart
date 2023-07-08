import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/modules/analysis/widgets/debit_chart_item_widget.dart';

class DebiCharttWidget extends StatefulWidget {
  const DebiCharttWidget({
    super.key,
    required this.expenses,
  });
  final List<ExpenseModel> expenses;

  @override
  State<DebiCharttWidget> createState() => _DebiCharttWidgetState();
}

class _DebiCharttWidgetState extends State<DebiCharttWidget> {
  List<_UserExpenseModel> userDebit = [];
  List<_UserExpenseModel> userCredit = [];
  List<_UserChartModel> userChart = [];
  List<_UserExpenseModel> userAmountCredit = [];
  List<_UserExpenseModel> userAmountDebit = [];
  List<_ItemModel> userModel = [];

  @override
  void initState() {
    super.initState();
    _calculateDebit();
    _calculateItem();
  }

  void _calculateDebit() {
    List<ExpenseModel> newExpense = widget.expenses;
    for (var expenseItem in newExpense) {
      if (userDebit.isEmpty) {
        userDebit.add(_UserExpenseModel(
          name: expenseItem.createdBy.name,
          id: expenseItem.createdBy.userID,
          amount: expenseItem.amount,
        ));
      } else {
        bool isExist = false;
        for (var user in userDebit) {
          if (user.id == expenseItem.createdBy.userID) {
            user.amount += expenseItem.amount;
            isExist = true;
            break;
          }
        }
        if (!isExist) {
          userDebit.add(_UserExpenseModel(
            name: expenseItem.createdBy.name,
            id: expenseItem.createdBy.userID,
            amount: expenseItem.amount,
          ));
        }
      }
    }

    for (var expense in widget.expenses) {
      for (var element in expense.participants) {
        if (userCredit.isEmpty) {
          userCredit.add(_UserExpenseModel(
            name: element.name,
            id: element.userID,
            amount: expense.amount ~/ expense.participants.length,
          ));
        } else {
          bool isExist = false;
          for (var user in userCredit) {
            if (user.id == element.userID) {
              user.amount += expense.amount ~/ expense.participants.length;
              isExist = true;
              break;
            }
          }
          if (!isExist) {
            userCredit.add(_UserExpenseModel(
              name: element.name,
              id: element.userID,
              amount: expense.amount ~/ expense.participants.length,
            ));
          }
        }
      }
    }

    userDebit.sort((a, b) => a.amount.compareTo(b.amount));
    userCredit.sort((a, b) => a.amount.compareTo(b.amount));
    for (var element in userDebit) {
      userChart.add(
        _UserChartModel(
          name: element.name,
          id: element.id,
          credit: 0,
          debit: element.amount,
        ),
      );
    }
    for (var element in userCredit) {
      List<int> listId = userChart.map((e) => e.id).toList();
      if (listId.contains(element.id)) {
        userChart[userChart.indexWhere((chart) => chart.id == element.id)]
            .credit = element.amount;
      } else {
        userChart.add(
          _UserChartModel(
            name: element.name,
            id: element.id,
            credit: element.amount,
            debit: 0,
          ),
        );
      }
    }

    for (var user in userChart) {
      int amount = user.debit - user.credit;
      if (amount > 0) {
        userAmountCredit.add(_UserExpenseModel(
          name: user.name,
          id: user.id,
          amount: amount,
        ));
      } else if (amount < 0) {
        userAmountDebit.add(_UserExpenseModel(
          name: user.name,
          id: user.id,
          amount: amount,
        ));
      }
    }
  }

  void _calculateItem() {
    while (userAmountCredit.isNotEmpty) {
      // sort userAmountCredit by amount desc
      userAmountCredit.sort((a, b) => b.amount.compareTo(a.amount));
      // sort userAmountDebit by amount asc
      userAmountDebit.sort((a, b) => a.amount.compareTo(b.amount));

      int amount = userAmountCredit[0].amount + userAmountDebit[0].amount;
      if (amount > 0) {
        userModel.add(_ItemModel(
          debtName: userAmountCredit[0].name,
          balanceName: userAmountDebit[0].name,
          amount: userAmountDebit[0].amount.abs(),
          id: userAmountCredit[0].id,
        ));
        userAmountCredit[0].amount = amount;
        userAmountDebit.removeAt(0);
      } else if (amount < 0) {
        userModel.add(_ItemModel(
          debtName: userAmountCredit[0].name,
          balanceName: userAmountDebit[0].name,
          amount: userAmountCredit[0].amount.abs(),
          id: userAmountCredit[0].id,
        ));
        userAmountDebit[0].amount = amount;
        userAmountCredit.removeAt(0);
      } else {
        userModel.add(_ItemModel(
          debtName: userAmountCredit[0].name,
          balanceName: userAmountDebit[0].name,
          amount: userAmountCredit[0].amount.abs(),
          id: userAmountCredit[0].id,
        ));
        userAmountCredit.removeAt(0);
        userAmountDebit.removeAt(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Group Debt',
            style: TextStyles.titleBold,
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              _ItemModel item = userModel[index];
              return DebitChartItemWidget(
                amount: item.amount,
                firstName: item.debtName,
                lastName: item.balanceName,
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 10,
            ),
            itemCount: userModel.length,
          ),
        ],
      ),
    );
  }
}

class _UserExpenseModel {
  _UserExpenseModel({
    required this.name,
    required this.id,
    required this.amount,
  });

  final String name;
  int amount;
  final int id;
}

class _UserChartModel {
  final String name;
  int credit;
  int debit;
  final int id;

  _UserChartModel({
    required this.name,
    required this.credit,
    required this.debit,
    required this.id,
  });
}

class _ItemModel {
  final String debtName;
  final String balanceName;
  final int amount;
  final int id;

  _ItemModel({
    required this.debtName,
    required this.balanceName,
    required this.amount,
    required this.id,
  });
}
