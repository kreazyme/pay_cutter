import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/endpoints.dart';
import 'package:pay_cutter/common/helper/dio_helper.dart';
import 'package:pay_cutter/data/datasource/mock/chat.mock.dart';
import 'package:pay_cutter/data/models/chat.model.dart';

@LazySingleton()
class ChatDataSource {
  final DioHelper _dioHelper;
  const ChatDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<List<ChatModel>> fetchChats(String id) async {
    await Future.delayed(const Duration(seconds: 4));
    return ChatMock.getListChat();
  }

  Future<String> getShareChatUrl(int id) async {
    final response = await _dioHelper.post(
      AppEndpoints.share,
      data: {'id': id},
    );
    return response.body['data'];
  }
}
