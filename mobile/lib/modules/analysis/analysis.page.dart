import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/modules/analysis/bloc/analysis_bloc.dart';
import 'package:pay_cutter/modules/analysis/widgets/category_chart.widget.dart';
import 'package:pay_cutter/modules/analysis/widgets/date_chart.widget.dart';
import 'package:pay_cutter/modules/analysis/widgets/participants_chart.widget.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({
    super.key,
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AnalysisBloc(),
        child: BlocListener<AnalysisBloc, AnalysisState>(
          listener: _onListener,
          child: _AnalysisView(
            expenses: expenses,
          ),
        ));
  }

  void _onListener(BuildContext context, AnalysisState state) {
    if (state is AnalysisInitial) {}
  }
}

class _AnalysisView extends StatelessWidget {
  const _AnalysisView({
    required this.expenses,
  });
  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Analysis'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Chart by Category',
                    style: TextStyles.titleBold,
                  ),
                  Container(
                    height: 400,
                    padding: const EdgeInsets.only(right: 52),
                    child: CategoryChartWidget(
                      expenses: expenses,
                    ),
                  ),
                ],
              ),
            ),
            ParticipantChartWidget(
              expenses: expenses,
            ),
            // SizedBox(
            //   height: 400,
            //   child: DateChartWidget(
            //     expenses: expenses,
            //   ),
            // ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
