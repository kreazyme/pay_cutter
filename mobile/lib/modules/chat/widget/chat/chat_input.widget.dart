import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/modules/chat/chat/chat_bloc.dart';

class ChatInputWidget extends StatelessWidget {
  ChatInputWidget({super.key});
  final TextEditingController _textController = TextEditingController();

  void _sendMessage(String message, BuildContext context) {
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(ChatSent(content: message));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: TextField(
              controller: _textController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Send a message'),
              onSubmitted: (message) => _sendMessage(
                message,
                context,
              ),
            )),
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  _sendMessage(
                    _textController.text,
                    context,
                  );
                  _textController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
