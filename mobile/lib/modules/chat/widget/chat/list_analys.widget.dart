// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
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
  List<_ItemAnalys> balancing = [];

  @override
  void initState() {
    super.initState();
    _calculateDebit();
  }

  void _calculateDebit() {
    List<_ItemAnalys> spending = [];
    List<_ItemAnalys> debt = [];
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
        spending.add(_ItemAnalys(
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
              e.total += amountPerPerson;
            }
          }).toList();
        } else {
          debt.add(
            _ItemAnalys(
              name: paiding.name,
              total: amountPerPerson,
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

    for (var element in debt) {
      List<_ItemAnalys> ls =
          spending.where((p0) => p0.id == element.id).toList();
      if (ls.isEmpty) return;
      _ItemAnalys e = ls.first;
      balancing.add(_ItemAnalys(
        name: e.name,
        total: e.total - element.total,
        id: e.id,
        color: e.color,
      ));
    }

    setState(() {
      balancing;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty || balancing.isEmpty) {
      return Container();
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: balancing.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 20,
          color: Colors.green,
          width: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(balancing[index].name),
              Text(balancing[index].total.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Color _generateRandomColor() {
    return Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
  }
}

class _ItemAnalys {
  final String name;
  int total;
  final Color color;
  final int id;

  _ItemAnalys({
    required this.name,
    required this.total,
    required this.id,
    required this.color,
  });
}
