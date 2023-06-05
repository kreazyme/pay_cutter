import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/modules/chat/detail/detail_chat_bloc.dart';
import 'package:pay_cutter/modules/chat/widget/detail/detail_item_button.widget.dart';
import 'package:pay_cutter/modules/chat/widget/detail/detail_profile.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({
    super.key,
    required this.group,
  });

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailChatBloc(),
      child: BlocListener<DetailChatBloc, DetailChatState>(
        listener: _onListener,
        child: _DetailChatView(
          group: group,
        ),
      ),
    );
  }

  void _onListener(
    BuildContext context,
    DetailChatState state,
  ) {}
}

class _DetailChatView extends StatelessWidget {
  const _DetailChatView({
    required this.group,
  });
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Chat'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DetailProfileWidget(
                name: group.name,
                imageURL: group.imageURL,
              ),
              DetailItemButtonWidget(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouters.shareChat,
                    arguments: group.id,
                  );
                },
                title: 'Share group',
                icon: const Icon(Icons.share),
              ),
              DetailItemButtonWidget(
                onPressed: () {},
                title: 'Analytics',
                icon: const Icon(Icons.analytics_outlined),
              ),
              DetailItemButtonWidget(
                onPressed: () {},
                title: 'All expenses',
                icon: const Icon(Icons.list_alt_outlined),
              ),
              DetailItemButtonWidget(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouters.participants,
                    arguments: group.participants,
                  );
                },
                title: 'Participants',
                icon: const Icon(Icons.people),
              ),
              DetailItemButtonWidget(
                onPressed: () {},
                title: 'Leave group',
                isWarning: true,
                icon: Icon(Icons.logout_outlined, color: AppColors.alertText),
              ),
            ],
          ),
        ));
  }
}
