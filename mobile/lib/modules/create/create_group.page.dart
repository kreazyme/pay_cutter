import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custom_textfield.widget.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/create/bloc/create_group/create_group_bloc.dart';
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
          child: _CreateGroupView(),
        ));
  }

  void _onListner(
    BuildContext context,
    CreateGroupState state,
  ) {
    if (state is CreateGroupSuccess) {
      Navigator.pushNamed(context, AppRouters.chat, arguments: state.group);
    }
  }
}

// ignore: must_be_immutable
class _CreateGroupView extends StatelessWidget {
  _CreateGroupView();

  String _groupName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: BlocBuilder<CreateGroupBloc, CreateGroupState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextFielddWidget(
                keyboardType: TextInputType.text,
                hintText: 'Group Name',
                labelText: 'Group Name',
                onChanged: (value) {
                  _groupName = value;
                },
              ),
              CustomButtonWidget(
                content: 'Create',
                isLoading: state.status.isLoading,
                onPressed: () {
                  context.read<CreateGroupBloc>().add(CreateGroupSubmit(
                        name: _groupName,
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
