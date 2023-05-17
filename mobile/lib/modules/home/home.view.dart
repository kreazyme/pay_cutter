import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/widgets/animation/app_loading.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/home/widgets/home_fab.widget.dart';
import 'package:pay_cutter/modules/home/widgets/list_chat_group.widget.dart';

import 'bloc/home.bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        groupRepository: getIt.get<GroupRepository>(),
      ),
      child: BlocListener<HomeBloc, HomeState>(
        listener: _onListener,
        child: const _HomeView(),
      ),
    );
  }

  void _onListener(BuildContext context, HomeState state) {
    // if (state.status.isError) {
    //   ToastUlti.showError(context, state.error!);
    // }
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        body: Builder(
          builder: (context) {
            if (state.status.isLoading) {
              return const Center(
                child: AppCustomLoading(),
              );
            }
            if (state.status.isError) {
              const Center(
                child: Text('Error'),
              );
            }
            return ListChatGroup(groups: state.groups);
          },
        ),
        floatingActionButton: const HomeFABWidget(),
      ),
    );
  }
}
