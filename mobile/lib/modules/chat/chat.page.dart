// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/common/widgets/animation/app_loading.widget.dart';
import 'package:pay_cutter/common/widgets/custom_app_error.widget.dart';
import 'package:pay_cutter/common/widgets/custom_icon.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/chat/chat/chat_bloc.dart';
import 'package:pay_cutter/modules/chat/widget/chat/list_analys.widget.dart';
import 'package:pay_cutter/modules/chat/widget/chat/list_chats.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.params});

  final ParamsWrapper2<GroupModel, bool> params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        group: params.param1,
        expenseRepository: getIt.get<ExpenseRepository>(),
        groupRepo: getIt.get<GroupRepository>(),
      ),
      child: BlocListener<ChatBloc, ChatState>(
        listener: _onListener,
        child: _ChatView(
          params: params,
        ),
      ),
    );
  }

  void _onListener(BuildContext context, ChatState state) {
    if (state is ChatFailure) {
      ToastUlti.showError(context, '');
    }
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({
    required this.params,
  });

  final ParamsWrapper2<GroupModel, bool> params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: params.param1.name,
          onLeadingAction: () {
            if (params.param2) {
              Navigator.of(context).pop(params.param1);
            } else {
              Navigator.of(context).pop();
            }
          },
          actions: [
            IconButton(
              icon: const CustomIcon(iconData: Icons.info_outline),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRouters.detail,
                arguments: params.param1,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(
                    child: AppCustomLoading(),
                  );
                } else if (state is ChatSuccessful) {
                  if (state.expenses.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text('No expenses found!'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRouters.shareChat,
                              arguments: params.param1.id,
                            ),
                            child: const Text('Share this group to others'),
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView(
                    children: [
                      ListAnalysWidget(
                        expenses: state.expenses,
                        group: params.param1,
                      ),
                      ListChatsWidget(
                        expenses: state.expenses,
                        group: params.param1,
                      ),
                    ],
                  );
                } else {
                  return const CustomAppErrorWidget();
                }
              },
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouters.scanBill,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: const Icon(
                    Icons.document_scanner_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return Container();
            }
            return FloatingActionButton(
              onPressed: () async {
                Object? response = await Navigator.pushNamed(
                  context,
                  AppRouters.createExpense,
                  arguments: state.group,
                );
                if (response != null) {
                  context.read<ChatBloc>().add(
                        ChatAddExpense(
                          expense: response as ExpenseModel,
                        ),
                      );
                }
              },
              child: const CustomIcon(
                iconData: Icons.add,
                iconSize: 24,
              ),
            );
          },
        ));
  }
}
