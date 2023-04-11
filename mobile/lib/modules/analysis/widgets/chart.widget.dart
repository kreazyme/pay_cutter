import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    super.key,
  });

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final List<double> valueData = [10, 20, 30, 40];
  final List<Color> chartColors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.yellow
  ];
  final List<String> title = [
    'Food',
    'Transport',
    'Entertainment',
    'Others',
  ];

  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
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
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    return valueData.map((e) {
      int index = valueData.indexOf(e);
      bool isTouched = index == _touchedIndex;
      return PieChartSectionData(
        color: chartColors[index],
        value: valueData[index],
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
