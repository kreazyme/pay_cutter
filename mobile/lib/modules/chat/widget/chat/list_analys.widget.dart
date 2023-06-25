import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pay_cutter/common/extensions/double.extension.dart';
import 'package:pay_cutter/common/helper/number_format/number_formarter.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';

class ListAnalysWidget extends StatefulWidget {
  const ListAnalysWidget({
    super.key,
    required this.expenses,
    required this.group,
  });

  final List<ExpenseModel> expenses;
  final GroupModel group;

  @override
  State<ListAnalysWidget> createState() => _ListAnalysWidgetState();
}

class _ListAnalysWidgetState extends State<ListAnalysWidget> {
  List<ItemAnalysModel> balancing = [];
  double xPadding = 0;
  double yPadding = 0;

  @override
  void initState() {
    super.initState();
  }

  void _calculateDebit() {
    balancing = [];
    List<ItemAnalysModel> spending = [];
    List<ItemAnalysModel> debt = [];
    for (var expense in widget.expenses) {
      List<int> ids = spending.map((e) => e.id).toList();
      if (ids.contains(expense.createdBy.userID)) {
        // add total
        spending.map((e) {
          if (e.id == expense.createdBy.userID) {
            e.total += expense.amount;
          }
        }).toList();
      } else {
        spending.add(ItemAnalysModel(
          name: expense.createdBy.name,
          total: expense.amount,
          id: expense.createdBy.userID,
          color: _generateRandomColor(),
        ));
      }
    }

    for (var expense in widget.expenses) {
      for (var paiding in expense.participants) {
        List<int> ids = debt.map((e) => e.id).toList();
        int amountPerPerson = expense.amount ~/ expense.participants.length;
        if (ids.contains(paiding.userID)) {
          // add total
          debt.map((e) {
            if (e.id == paiding.userID) {
              e.total -= amountPerPerson;
            }
          }).toList();
        } else {
          debt.add(
            ItemAnalysModel(
              name: paiding.name,
              total: -amountPerPerson,
              id: paiding.userID,
              color: _generateRandomColor(),
            ),
          );
        }
      }
    }

    if (spending.isEmpty && debt.isEmpty) return;

    if (spending.isEmpty) {
      setState(() {
        balancing = debt;
      });
    }

    if (debt.isEmpty) {
      setState(() {
        balancing = spending;
      });
    }

    // add debt to balance
    for (var element in debt) {
      _addItemToBalance(element);
    }

    // add spending to balance
    for (var element in spending) {
      _addItemToBalance(element);
    }

    balancing.map((e) => e.addColor()).toList();

    setState(() {
      balancing;
    });
  }

  void _addItemToBalance(ItemAnalysModel item) {
    if (balancing.isEmpty) {
      balancing.add(item);
    } else {
      // check if item not exist
      if (!balancing.map((e) => e.id).contains(item.id)) {
        balancing.add(item);
        return;
      }
      balancing = balancing.map((e) {
        if (e.id == item.id) {
          e.total += item.total;
        }
        return e;
      }).toList();
    }
  }

  double _calculateSize(double amount) {
    if (balancing.isEmpty) return 0;
    if (balancing.length == 1) return 120;
    List<double> amounts = balancing.map((e) => e.total.toDouble()).toList();
    amounts.sort();
    double distance = amounts.last - amounts.first;
    return ((amount - amounts.first) / distance * 30).toPositive + 120;
  }

  @override
  Widget build(BuildContext context) {
    _calculateDebit();
    if (widget.expenses.isEmpty || balancing.isEmpty) {
      return Container();
    }

    return Container(
      height: 400,
      color: AppColors.backgroundColor,
      width: double.infinity,
      child: Stack(
        children: [
          ...balancing.map((e) {
            return _ItemAnalysWidget(
              item: e,
              size: _calculateSize(e.total.toDouble()),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ItemAnalysModel {
  final String name;
  int total;
  final Color color;
  final int id;

  ItemAnalysModel addColor() => ItemAnalysModel(
        name: name,
        total: total,
        id: id,
        color: _generateRandomColor(),
      );

  ItemAnalysModel({
    required this.name,
    required this.total,
    required this.id,
    required this.color,
  });
}

class _ItemAnalysWidget extends StatefulWidget {
  const _ItemAnalysWidget({
    required this.item,
    required this.size,
  });

  final ItemAnalysModel item;
  final double size;

  @override
  State<_ItemAnalysWidget> createState() => _ItemAnalysWidgetState();
}

class _ItemAnalysWidgetState extends State<_ItemAnalysWidget> {
  double xPadding = 100;
  double yPadding = 150;

  String _getAmount() {
    return widget.item.total < 0
        ? '-${NumberFormatter.formatter(widget.item.total * -1)}'
        : NumberFormatter.formatter(widget.item.total);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
    ).then((value) {
      setState(() {
        xPadding = _getRandomPadding(300);
        yPadding = _getRandomPadding(300);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(
        milliseconds: 700,
      ),
      top: xPadding,
      left: yPadding,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (details) {
          setState(() {
            xPadding += details.delta.dy;
            yPadding += details.delta.dx;
          });
        },
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            color: widget.item.color,
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.item.name,
              ),
              const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              Text(
                _getAmount(),
                style: TextStyles.titleBold.copyWith(
                  color: AppColors.textColor.withOpacity(
                    0.7,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _getRandomPadding(double value) {
    double padding = 0;
    while (padding < 50 || padding > value - 50) {
      padding = Random().nextDouble() * value;
    }
    return padding;
  }
}

Color _generateRandomColor() {
  return Color.fromARGB(
    255,
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
  ).withOpacity(0.5);
}
