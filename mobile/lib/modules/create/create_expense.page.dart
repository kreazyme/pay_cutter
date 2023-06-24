import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/extensions/extensions.dart';
import 'package:pay_cutter/common/extensions/string.extentions.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/common/widgets/app_select.widget.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custom_icon.widget.dart';
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
  CreateExpensePage({
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
            amountController: amountController,
          ),
        ));
  }

  final TextEditingController amountController = TextEditingController();

  void _onListener(BuildContext context, CreateExpenseState state) {
    if (state.status?.isError == true) {
      ToastUlti.showError(context, state.error!);
    }
    if (state.expenseAmount != null && state.expenseAmount! > 0) {
      amountController.text = state.expenseAmount.toString();
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
    required TextEditingController amountController,
  }) : _amountController = amountController;
  final GroupModel groupModel;
  final TextEditingController _amountController;

  @override
  // ignore: no_logic_in_create_state
  State<_CreateExpenseView> createState() => _CreateExpenseViewState(
        amountController: _amountController,
      );
}

class _CreateExpenseViewState extends State<_CreateExpenseView> {
  _CreateExpenseViewState({
    required TextEditingController amountController,
  }) : _amountController = amountController;
  final TextEditingController _amountController;
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreateExpenseBloc>(context).add(CreateExpenseStarted(
      groupModel: widget.groupModel,
    ));
  }

  double _amount(String value) {
    if (value == '' || value == '-' || value == ',' || value == '.') {
      return 0;
    }
    if (value.lastCharacter == ',' || value.lastCharacter == '.') {
      return double.parse(value.substring(0, value.length - 1));
    }
    return double.parse(value);
  }

  void _showCameraDialog(BuildContext c) {
    showModalBottomSheet(
      context: c,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Upload an image, or take a photo to scan the receipt for this expense. This process is automatic and may take a few minutes.',
                style: TextStyles.body,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  c.read<CreateExpenseBloc>().add(
                        CreateExpenseTakePicture(
                          groupId: widget.groupModel.id,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Take a photo',
                      style: TextStyles.title.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  c.read<CreateExpenseBloc>().add(
                        CreateExpenseUploadFile(
                          groupId: widget.groupModel.id,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Upload from gallery',
                      style: TextStyles.title.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amoutInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: TextField(
          controller: _amountController,
          style: TextStyles.h1.copyWith(
            color: AppColors.primaryColor,
          ),
          onChanged: (value) {
            double amount = _amount(value);
            BlocProvider.of<CreateExpenseBloc>(context).add(
              CreateExpenseChangeAmount(
                amount: amount,
              ),
            );
          },
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
        )),
        GestureDetector(
          onTap: () {
            _showCameraDialog(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: CustomIcon(
              iconData: Icons.document_scanner_outlined,
              iconColor: AppColors.primaryColor,
            ),
          ),
        )
      ],
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
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                _selectedDate.toFullDayWeek(),
                style: TextStyles.body.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ],
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
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              arguments:
                                  ParamsWrapper2<int, List<CategoryModel>>(
                                param1: widget.groupModel.id,
                                param2: state.categories ?? [],
                              ),
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
                          amount: state.amount ?? 0,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          imageUrl: state.imageUrl,
                          location: state.location,
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
