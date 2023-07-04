import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pay_cutter/common/helper/number_format/number_formarter.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/data/models/expense.model.dart';

class ParticipantChartWidget extends StatefulWidget {
  const ParticipantChartWidget({
    super.key,
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  State<ParticipantChartWidget> createState() => _ParticipantChartWidgetState();
}

class _ParticipantChartWidgetState extends State<ParticipantChartWidget> {
  List<_UserExpenseModel> userDebit = [];
  List<_UserExpenseModel> userCredit = [];
  List<_UserChartModel> userChart = [];
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  final double width = 12;

  @override
  void initState() {
    super.initState();
    _calculateDebit();
    rawBarGroups = userChart
        .map((e) => BarChartGroupData(
              barsSpace: 4,
              x: 4,
              barRods: [
                BarChartRodData(
                  toY: e.credit.toDouble(),
                  color: Colors.blue,
                  width: width,
                ),
                BarChartRodData(
                  toY: e.debit.toDouble(),
                  color: Colors.green,
                  width: width,
                ),
              ],
            ))
        .toList();
    showingBarGroups = List.of(rawBarGroups);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text('Chart by participants', style: TextStyles.titleBold),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 400,
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 72,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: showingBarGroups,
                gridData: FlGridData(show: false),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Amount Spent',
                style: TextStyles.body.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Amount Paid',
                style: TextStyles.body.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(NumberFormatter.formatter(value.toInt()), style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    var listValue = userChart.map((e) => e.id).toList();

    final Widget text = Text(
      userChart[listValue.indexOf(value.toInt())].name,
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.green,
          width: 4,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.yellow,
          width: 4,
        ),
      ],
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
