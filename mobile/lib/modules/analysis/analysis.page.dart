import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/modules/analysis/bloc/analysis_bloc.dart';
import 'package:pay_cutter/modules/analysis/widgets/chart.widget.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AnalysisBloc(),
        child: BlocListener<AnalysisBloc, AnalysisState>(
          listener: _onListener,
          child: const _AnalysisView(),
        ));
  }

  void _onListener(BuildContext context, AnalysisState state) {
    if (state is AnalysisInitial) {}
  }
}

class _AnalysisView extends StatelessWidget {
  const _AnalysisView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis'),
      ),
      body: const SizedBox(
        width: 300,
        height: 300,
        child: ChartWidget(),
      ),
    );
  }
}
