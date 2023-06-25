import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pay_cutter/common/helper/number_format/number_formarter.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/expense.model.dart';

class CategoryChartWidget extends StatefulWidget {
  const CategoryChartWidget({
    super.key,
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  State<CategoryChartWidget> createState() => _CategoryChartWidgetState();
}

class _CategoryChartWidgetState extends State<CategoryChartWidget> {
  List<_CategoryItem> category = [];
  void _initCategory() {
    List<ExpenseModel> newExpense = widget.expenses;
    newExpense.map((e) {
      if (e.category == null) {
        return ExpenseModel(
          id: e.id,
          name: e.name,
          amount: e.amount,
          createdAt: e.createdAt,
          updatedAt: e.updatedAt,
          createdBy: e.createdBy,
          participants: e.participants,
          category: CategoryModel.other(),
        );
      } else {
        return e;
      }
    });
    for (var expenseItem in newExpense) {
      if (category.isEmpty) {
        category.add(_CategoryItem(
          title: expenseItem.category!.name,
          value: expenseItem.amount,
        ));
      } else {
        bool isExist = false;
        for (var cat in category) {
          if (cat.title == expenseItem.category!.name) {
            cat.value += expenseItem.amount;
            isExist = true;
            break;
          }
        }
        if (!isExist) {
          category.add(_CategoryItem(
            title: expenseItem.category!.name,
            value: expenseItem.amount,
          ));
        }
      }
    }
    category.sort((a, b) => b.value.compareTo(a.value));
    setState(() {
      valueData = category.map((e) => e.value).toList();
      title = category.map((e) => e.title).toList();
    });
  }

  List<int> valueData = [10, 20, 30, 40];
  final List<Color> chartColors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
  ];
  List<String> title = [
    'Food',
    'Transport',
    'Entertainment',
    'Others',
  ];

  List<Widget> _buildCategory() {
    List<Widget> list = [];
    for (var item in category) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: chartColors[category.indexOf(item)],
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(NumberFormatter.formatter(item.value)),
            ],
          ),
        ),
      );
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _initCategory();
  }

  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      _touchedIndex = -1;
                      return;
                    }
                    _touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: _showingSections(),
            ),
          ),
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _buildCategory(),
        )
      ],
    );
  }

  List<PieChartSectionData> _showingSections() {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    return title.map((e) {
      int index = title.indexOf(e);
      bool isTouched = index == _touchedIndex;
      return PieChartSectionData(
        color: chartColors[index],
        value: valueData[index].toDouble(),
        title: title[index],
        radius: isTouched ? 80 : 70.0,
        titleStyle: TextStyle(
          fontSize: isTouched ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}

class _CategoryItem {
  String title;
  int value;

  _CategoryItem({
    required this.title,
    required this.value,
  });
}
