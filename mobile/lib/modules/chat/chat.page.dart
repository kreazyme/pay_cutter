import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/widgets/animation/app_loading.widget.dart';
import 'package:pay_cutter/common/widgets/custom_app_error.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/chat_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/chat/chat/chat_bloc.dart';
import 'package:pay_cutter/modules/chat/widget/chat/list_chats.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        chatRepository: getIt.get<ChatRepository>(),
      ),
      child: BlocListener<ChatBloc, ChatState>(
        listener: _onListener,
        child: _ChatView(
          group: group,
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
    required this.group,
  });

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () => Navigator.pushNamed(
              context,
              AppRouters.detail,
              arguments: group,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: AppCustomLoading(),
            );
          } else if (state is ChatSuccessful) {
            return ListChatsWidget(
              chats: state.chats!,
              group: group,
            );
          } else {
            return const CustomAppErrorWidget();
          }
        },
      ),
    );
  }
}
