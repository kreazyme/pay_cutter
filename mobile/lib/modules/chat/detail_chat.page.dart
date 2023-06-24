import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/models/dto/push_noti.dto.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/chat/detail/detail_chat_bloc.dart';
import 'package:pay_cutter/modules/chat/widget/detail/detail_item_button.widget.dart';
import 'package:pay_cutter/modules/chat/widget/detail/detail_profile.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({
    super.key,
    required this.group,
    required this.expenses,
  });

  final GroupModel group;
  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailChatBloc(
        groupRepository: getIt.get<GroupRepository>(),
      ),
      child: BlocListener<DetailChatBloc, DetailChatState>(
        listener: _onListener,
        child: _DetailChatView(
          group: group,
          expenses: expenses,
        ),
      ),
    );
  }

  void _onListener(
    BuildContext context,
    DetailChatState state,
  ) {
    if (state is DetailChatFileSaved) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Export data success!',
                style: TextStyles.title,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'File saved to Download Folder',
                style: TextStyles.body,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class _DetailChatView extends StatefulWidget {
  _DetailChatView({
    required this.group,
    required this.expenses,
  });
  final GroupModel group;
  final List<ExpenseModel> expenses;

  @override
  State<_DetailChatView> createState() => _DetailChatViewState();
}

class _DetailChatViewState extends State<_DetailChatView> {
  final UserRepo _userRepo = getIt.get<UserRepo>();
  String userName = 'Someone';

  void _getUserName() async {
    userName = (await _userRepo.getUser()).name;
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          title: 'Detail Group',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              children: [
                DetailProfileWidget(
                  name: widget.group.name,
                  imageURL: widget.group.imageURL,
                ),
                DetailItemButtonWidget(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouters.participants,
                      arguments: widget.group.participants,
                    );
                  },
                  title: 'Participants',
                  icon: const Icon(Icons.people),
                ),
                DetailItemButtonWidget(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouters.shareChat,
                      arguments: widget.group.id,
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
                  onPressed: () {
                    context.read<DetailChatBloc>().add(
                          DetailChatSendPushNoti(
                              input: PushNotiDTO(
                            ids: widget.group.participants
                                .map((e) => e.userID)
                                .toList(),
                            isAnonymous: false,
                            sender: userName,
                            groupName: widget.group.name,
                          )),
                        );
                  },
                  title: 'Remind to pay',
                  icon: const Icon(Icons.notifications_on_outlined),
                ),
                DetailItemButtonWidget(
                  onPressed: () {
                    context.read<DetailChatBloc>().add(
                          DetailChatSaveFile(
                            expenses: widget.expenses,
                            groupName: widget.group.name,
                          ),
                        );
                  },
                  title: 'Export data',
                  icon: const Icon(Icons.file_download_outlined),
                ),
                DetailItemButtonWidget(
                  onPressed: () {},
                  title: 'Leave group',
                  isWarning: true,
                  icon: Icon(Icons.logout_outlined, color: AppColors.alertText),
                ),
              ],
            ),
          ),
        ));
  }
}
