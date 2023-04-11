import 'package:flutter/material.dart';
import 'package:pay_cutter/data/models/chat.model.dart';

class ItemChatWidget extends StatefulWidget {
  const ItemChatWidget({
    super.key,
    required this.chat,
  });

  final ChatModel chat;

  @override
  State<ItemChatWidget> createState() => _ItemChatWidgetState();
}

class _ItemChatWidgetState extends State<ItemChatWidget> {
  final isSender = true;
  bool isShowTime = false;

  void _handleTouch() {
    setState(() {
      isShowTime = !isShowTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTouch(),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: isSender
                  ? Theme.of(context).primaryColor
                  : const Color(0xFFE9E9E9),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
                bottomLeft: isSender
                    ? const Radius.circular(12.0)
                    : const Radius.circular(0),
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(12.0),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.content,
                  style: TextStyle(
                    color: isSender ? Colors.white : Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                if (isShowTime)
                  Text(
                    '${widget.chat.createdAt.hour}:${widget.chat.createdAt.minute}  ✓ ',
                    style: TextStyle(
                      color: isSender
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black54,
                      fontSize: 12.0,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
