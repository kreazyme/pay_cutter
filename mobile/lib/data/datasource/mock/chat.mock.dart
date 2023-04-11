import 'package:pay_cutter/data/models/chat.model.dart';

abstract class ChatMock {
  static List<ChatModel> getListChat() => List.generate(
      20,
      (index) => ChatModel(
            id: 'id20',
            content: 'content',
            senderId: 'senderId',
            createdAt: DateTime.now(),
          ));
}
