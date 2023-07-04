import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/data/models/dto/push_noti.dto.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/chat/detail/detail_chat_bloc.dart';

class DialogRemindWidget extends StatefulWidget {
  const DialogRemindWidget({
    super.key,
    required this.group,
  });
  final GroupModel group;

  @override
  State<DialogRemindWidget> createState() => _DialogRemindWidgetState();
}

class _DialogRemindWidgetState extends State<DialogRemindWidget> {
  bool _isAnonymous = false;
  String _userName = 'Someone';
  final UserRepo _userRepo = getIt.get<UserRepo>();

  void _getUserName() async {
    _userName = (await _userRepo.getUser()).name;
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailChatBloc, DetailChatState>(
      builder: (context, state) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Remind to pay'),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isAnonymous,
                    onChanged: (value) {
                      setState(() {
                        _isAnonymous = value!;
                      });
                    },
                  ),
                  const Text('Send this Remind as Anonymous'),
                ],
              ),
              const Text('Are you sure?'),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<DetailChatBloc>().add(
                      DetailChatSendPushNoti(
                          input: PushNotiDTO(
                        ids: widget.group.participants
                            .map((e) => e.userID)
                            .toList(),
                        isAnonymous: false,
                        sender: _userName,
                        groupName: widget.group.name,
                      )),
                    );
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
