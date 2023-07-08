import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pay_cutter/data/models/expense.model.dart';

class DateChartWidget extends StatefulWidget {
  const DateChartWidget({
    super.key,
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  State<DateChartWidget> createState() => _DateChartWidgetState();
}

class _DateChartWidgetState extends State<DateChartWidget> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  List<_DateChartItem> _dateChartItems = [];
  late List<FlSpot> _spots;

  void _calculateDate() {
    widget.expenses.forEach((expense) {
      if (_dateChartItems.isEmpty) {
        _dateChartItems.add(_DateChartItem(
          date: expense.createdAt,
          amount: expense.amount,
        ));
      } else {
        List<DateTime> dates = _dateChartItems.map((e) => e.date).toList();
        bool isExist = dates.contains(expense.createdAt);
        if (isExist) {
          int index = dates.indexOf(expense.createdAt);
          _dateChartItems[index] = _DateChartItem(
            date: expense.createdAt,
            amount: _dateChartItems[index].amount + expense.amount,
          );
        } else {
          _dateChartItems.add(_DateChartItem(
            date: expense.createdAt,
            amount: expense.amount,
          ));
        }
      }
    });

    // set flspot
    _spots = _dateChartItems
        .map((e) => FlSpot(
              e.date.day.toDouble(),
              e.amount.toDouble(),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _calculateDate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Text(value.toString(), style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
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
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      // minX: 0,
      // maxX: 11,
      // minY: 0,
      // maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: _spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateChartItem {
  final DateTime date;
  final int amount;

  const _DateChartItem({
    required this.date,
    required this.amount,
  });
}
