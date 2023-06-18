import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custom_textfield.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/datasource/remote/category.datasource.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/create/bloc/create_category/create_category_bloc.dart';

class CreateCategoryPage extends StatelessWidget {
  const CreateCategoryPage({
    super.key,
    required this.groupId,
  });

  final int groupId;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CreateCategoryBloc(
          categoryDataSource: getIt.get<CategoryDataSource>(),
        ),
        child: BlocListener<CreateCategoryBloc, CreateCategoryState>(
          listener: _onListener,
          child: _CreateCategoryView(
            groupId: groupId,
          ),
        ),
      );

  void _onListener(BuildContext context, CreateCategoryState state) {
    if (state is CreateCategorySuccess) {
      Navigator.pop(
        context,
        state.category,
      );
    }
  }
}

class _CreateCategoryView extends StatefulWidget {
  const _CreateCategoryView({
    required this.groupId,
  });

  final int groupId;

  @override
  State<_CreateCategoryView> createState() => __CreateCategoryViewState();
}

class __CreateCategoryViewState extends State<_CreateCategoryView> {
  String _categoryName = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create Category',
      ),
      body: BlocBuilder<CreateCategoryBloc, CreateCategoryState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFielddWidget(
                      keyboardType: TextInputType.text,
                      hintText: 'Rent house 🏠',
                      labelText: 'Name of category',
                      onChanged: (value) {
                        setState(() {
                          _categoryName = value;
                        });
                      },
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    CustomTextFielddWidget(
                      keyboardType: TextInputType.text,
                      hintText: 'Money for rent house',
                      labelText: 'Description',
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              Builder(
                builder: (c) => CustomButtonWidget(
                  content: 'Create',
                  isLoading: state.status.isLoading,
                  isDiable: state.status.isLoading || _categoryName == '',
                  onPressed: () async {
                    BlocProvider.of<CreateCategoryBloc>(c).add(
                      CreateCategorySubmit(
                        name: _categoryName,
                        description: _description,
                        groupId: widget.groupId,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
