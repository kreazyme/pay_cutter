import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/repository/chat_repo.dart';

part 'share_chat_event.dart';
part 'share_chat_state.dart';

class ShareChatBloc extends Bloc<ShareChatEvent, ShareChatState> {
  final ChatRepository _chatRepository;
  ShareChatBloc({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const ShareChatInitial()) {
    on<ShareChatUrlGet>(_getChatURL);
  }

  Future<void> _getChatURL(
    ShareChatUrlGet event,
    Emitter<ShareChatState> emitter,
  ) async {
    try {
      final response = await _chatRepository.getShareChatUrl(event.id);
      emitter(ShareChatSuccess(url: response));
    } catch (e) {
      emitter(ShareChatFailure(error: e.toString()));
    }
  }
}
