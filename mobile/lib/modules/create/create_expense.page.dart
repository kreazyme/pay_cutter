import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/extensions/extensions.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/app_select.widget.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/datasource/firebase/firebase_upload.datasource.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/dto/expense.dto.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/category_repo.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/create/bloc/create_expense/create_expense_bloc.dart';
import 'package:pay_cutter/modules/create/widgets/expense/expense_for_whom.widget.dart';
import 'package:pay_cutter/modules/create/widgets/expense/expense_image.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class CreateExpensePage extends StatelessWidget {
  const CreateExpensePage({
    super.key,
    required this.group,
  });

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CreateExpenseBloc(
              expenseRepository: getIt.get<ExpenseRepository>(),
              categoryRepository: getIt.get<CategoryRepository>(),
              userRepo: getIt.get<UserRepo>(),
              firebaseUploadDataSoure: getIt.get<FirebaseUploadDataSoure>(),
            ),
        child: BlocListener<CreateExpenseBloc, CreateExpenseState>(
          listener: _onListener,
          child: _CreateExpenseView(
            groupModel: group,
          ),
        ));
  }

  void _onListener(BuildContext context, CreateExpenseState state) {
    if (state.status?.isError == true) {
      ToastUlti.showError(context, state.error!);
    }
    if (state.status?.isSuccess == true) {
      ToastUlti.showSuccess(context, 'Create Expense Success');
      Navigator.pop(
        context,
        state.expense,
      );
    }
  }
}

class _CreateExpenseView extends StatefulWidget {
  const _CreateExpenseView({
    required this.groupModel,
  });
  final GroupModel groupModel;

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
    BlocProvider.of<CreateExpenseBloc>(context).add(CreateExpenseStarted(
      groupModel: widget.groupModel,
    ));
  }

  Widget _amoutInput() {
    return TextField(
      controller: _amountController,
      style: TextStyles.h1.copyWith(
        color: AppColors.primaryColor,
      ),
      decoration: InputDecoration(
        label: Text(
          'Expense Amount',
          style: TextStyles.body.copyWith(
            color: AppColors.disableColor,
          ),
        ),
        hintText: '0',
        hintStyle: TextStyles.h1.copyWith(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _descriptionController,
                  style: TextStyles.title.copyWith(
                    color: AppColors.textColor,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                      'Name of Expense',
                      style: TextStyles.body.copyWith(
                        color: AppColors.disableColor,
                      ),
                    ),
                    hintText: 'Buy some food 🥪🌮',
                    hintStyle: TextStyles.body.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                _amoutInput(),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                Text(
                  'Category',
                  style: TextStyles.title.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const Divider(
                  height: 12,
                  color: Colors.transparent,
                ),
                AppSelectWidget(
                  onTap: () async {
                    Object? result = await Navigator.pushNamed(
                      context,
                      AppRouters.categoryPage,
                      arguments: state.categories,
                    );
                    if (result != null) {
                      if (mounted) {
                        BlocProvider.of<CreateExpenseBloc>(context).add(
                          CreateExpenseCategorySubmit(
                            category: result as CategoryModel,
                          ),
                        );
                      }
                    }
                  },
                  isLoading: state.categoryStatus?.isLoading == true,
                  title: state.categorySelected?.name,
                  placeholder: 'Select Category',
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
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                Text(
                  'Select datetime',
                  style: TextStyles.title.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const Divider(
                  height: 12,
                  color: Colors.transparent,
                ),
                _datetimeSelect(),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                ExpenseImageWidget(
                  groupId: widget.groupModel.id,
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                CustomButtonWidget(
                  content: 'Create',
                  isLoading: state.categoryStatus?.isLoading == true ||
                      state.imageStatus?.isLoading == true,
                  isDiable: _amountController.text == '' ||
                      state.status?.isLoading == true ||
                      state.categoryStatus?.isLoading == true ||
                      state.userSelected!.isEmpty ||
                      state.categorySelected == null ||
                      state.imageStatus?.isLoading == true,
                  onPressed: () {
                    BlocProvider.of<CreateExpenseBloc>(context).add(
                      CreateExpenseSubmit(
                        data: ExpenseDTO(
                          amount: double.parse(_amountController.text),
                          name: _descriptionController.text,
                          date: _selectedDate,
                          groupId: widget.groupModel.id,
                          participants: state.userSelected!
                              .map((e) => state.users![e].userID)
                              .toList(),
                          image: state.imageUrl ?? '',
                        ),
                      ),
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
