import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custom_textfield.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/create/bloc/create_expense/create_expense_bloc.dart';

class CreateExpensePage extends StatelessWidget {
  const CreateExpensePage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CreateExpenseBloc(
              expenseRepository: getIt.get<ExpenseRepository>(),
            ),
        child: BlocListener<CreateExpenseBloc, CreateExpenseState>(
          listener: _onListener,
          child: _CreateExpenseView(id: id),
        ));
  }

  void _onListener(BuildContext context, CreateExpenseState state) {
    if (state is CreateExpenseFailure) {
      ToastUlti.showError(context, state.error!);
    }
    if (state is CreateExpenseSuccess) {
      ToastUlti.showSuccess(context, 'Create Expense Success');
      Navigator.pop(context);
    }
  }
}

class _CreateExpenseView extends StatelessWidget {
  _CreateExpenseView({
    required this.id,
  });
  final String id;

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Expense'),
      ),
      body: BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  label: Text(
                    'Enter Amount',
                    style: TextStyles.body.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  hintText: '0',
                  hintStyle: TextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomButtonWidget(
              content: 'Test',
              onPressed: () {
                print(_amountController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
