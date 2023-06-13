import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custom_textfield.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/create/bloc/create_group/create_group_bloc.dart';
import 'package:pay_cutter/modules/home/bloc/home.bloc.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CreateGroupBloc(
              groupRepository: getIt.get<GroupRepository>(),
            ),
        child: BlocListener<CreateGroupBloc, CreateGroupState>(
          listener: _onListner,
          child: const _CreateGroupView(),
        ));
  }

  Future<void> _onListner(
    BuildContext context,
    CreateGroupState state,
  ) async {
    if (state is CreateGroupSuccess) {
      await Navigator.pushNamed(context, AppRouters.chat,
          arguments: ParamsWrapper2<GroupModel, bool>(
            param1: state.group!,
            param2: true,
          ));
      Navigator.pop(context, state.group!);
    }
  }
}

class _CreateGroupView extends StatefulWidget {
  const _CreateGroupView();

  @override
  State<_CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<_CreateGroupView> {
  String _groupName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create Group',
      ),
      body: BlocBuilder<CreateGroupBloc, CreateGroupState>(
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
                      hintText: 'Summer trip 🏊‍♀️',
                      labelText: 'Group Name',
                      onChanged: (value) {
                        setState(() {
                          _groupName = value;
                        });
                      },
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    CustomTextFielddWidget(
                      keyboardType: TextInputType.text,
                      hintText: 'To the beach 🏖️',
                      labelText: 'Description',
                      onChanged: (value) {},
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
                isLoading: state.status.isLoading,
                isDiable: state.status.isLoading || _groupName == '',
                onPressed: () async {
                  context.read<CreateGroupBloc>().add(
                        CreateGroupSubmit(name: _groupName),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
