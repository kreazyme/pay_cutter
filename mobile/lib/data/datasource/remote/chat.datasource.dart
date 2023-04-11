import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/mock/chat.mock.dart';
import 'package:pay_cutter/data/models/chat.model.dart';

@LazySingleton()
class ChatDataSource {
  const ChatDataSource();

  Future<List<ChatModel>> fetchChats(String id) async {
    await Future.delayed(const Duration(seconds: 4));
    return ChatMock.getListChat();
  }

  Future<String> getShareChatUrl(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://www.google.com';
  }
}
