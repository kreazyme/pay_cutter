import 'package:injectable/injectable.dart';
import 'package:pay_cutter/data/datasource/remote/chat.datasource.dart';
import 'package:pay_cutter/data/models/chat.model.dart';

@lazySingleton
class ChatRepository {
  final ChatDataSource _chatDataSource;
  const ChatRepository({
    required ChatDataSource chatDataSource,
  }) : _chatDataSource = chatDataSource;

  Future<List<ChatModel>> fetchChats(String id) async {
    return _chatDataSource.fetchChats(id);
  }

  Future<String> getShareChatUrl(int id) async {
    return _chatDataSource.getShareChatUrl(id);
  }
}
