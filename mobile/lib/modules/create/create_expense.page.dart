import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/extensions/extensions.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/repository/category_repo.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/create/bloc/create_expense/create_expense_bloc.dart';
import 'package:pay_cutter/modules/create/widgets/expense/expense_for_whom.widget.dart';
import 'package:pay_cutter/modules/create/widgets/expense/expense_image.widget.dart';

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
              categoryRepository: getIt.get<CategoryRepository>(),
            ),
        child: BlocListener<CreateExpenseBloc, CreateExpenseState>(
          listener: _onListener,
          child: _CreateExpenseView(id: id),
        ));
  }

  void _onListener(BuildContext context, CreateExpenseState state) {
    if (state.status?.isError == true) {
      ToastUlti.showError(context, state.error!);
    }
    if (state.status?.isSuccess == true) {
      ToastUlti.showSuccess(context, 'Create Expense Success');
      Navigator.pop(context);
    }
  }
}

class _CreateExpenseView extends StatefulWidget {
  const _CreateExpenseView({
    required this.id,
  });
  final String id;

  @override
  State<_CreateExpenseView> createState() => _CreateExpenseViewState();
}

class _CreateExpenseViewState extends State<_CreateExpenseView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreateExpenseBloc>(context)
        .add(CreateExpenseStarted(groupID: widget.id));
  }

  List<DropdownMenuItem> _getDropdown(List<CategoryModel>? items) {
    if (items == null) {
      return [];
    }
    return items
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.name),
            ))
        .toList();
  }

  Widget _amoutInput() {
    return TextField(
      controller: _amountController,
      style: TextStyles.title.copyWith(
        color: AppColors.primaryColor,
      ),
      decoration: InputDecoration(
        label: Text(
          'Expense Amount',
          style: TextStyles.body.copyWith(
            color: AppColors.textColor,
          ),
        ),
        hintText: '0',
        hintStyle: TextStyles.title.copyWith(
          color: AppColors.primaryColor,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.primaryColor,
        )),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _datetimeSelect() => Container(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2015, 8),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Text(
            _selectedDate.toFullDayWeek(),
            style: TextStyles.body.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create Expense',
      ),
      body: BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _amoutInput(),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      alignment: Alignment.centerLeft,
                      items: _getDropdown(state.categories),
                      onChanged: (item) {
                        BlocProvider.of<CreateExpenseBloc>(context).add(
                          CreateExpenseCategorySubmit(
                            category: item,
                          ),
                        );
                      },
                      value: state.categorySelected,
                      disabledHint: const Text('Loading'),
                      hint: const Text('Select Category'),
                      icon: Row(children: const [
                        VerticalDivider(
                          width: 20,
                          color: Colors.transparent,
                        ),
                        Icon(Icons.expand_more_outlined)
                      ]),
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.textColor,
                  height: 2,
                ),
                ExpenseForWhomWidget(
                  userSelected: state.userSelected ?? [],
                  users: state.users ?? [],
                  amount: double.parse(
                    _amountController.text.isEmpty
                        ? '0'
                        : _amountController.text,
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  style: TextStyles.body.copyWith(
                    color: AppColors.textColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyles.body.copyWith(
                      color: AppColors.textColor,
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    )),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                _datetimeSelect(),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                const ExpenseImageWidget(),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                CustomButtonWidget(
                  content: 'Create',
                  isLoading: state.categoryStatus?.isLoading ?? false,
                  isDiable: _amountController.text == '' ||
                      state.status?.isLoading == true ||
                      state.categoryStatus?.isLoading == true ||
                      state.userSelected!.isEmpty ||
                      state.categorySelected == null,
                  onPressed: () {
                    BlocProvider.of<CreateExpenseBloc>(context).add(
                      CreateExpenseSubmit(
                          data: ExpenseDTO(
                        amount: double.parse(_amountController.text),
                        description: _descriptionController.text,
                        date: _selectedDate,
                        name: 'Name',
                      )),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
