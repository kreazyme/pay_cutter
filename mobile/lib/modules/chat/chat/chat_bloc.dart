import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/chat.model.dart';
import 'package:pay_cutter/data/repository/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const ChatInitial()) {
    on<ChatStarted>(_started);
    on<ChatFetched>(_fetchChats);

    add(const ChatStarted());
  }

  Future<void> _started(
    ChatStarted event,
    Emitter<ChatState> emitter,
  ) async {
    emitter(const ChatLoading());
    add(const ChatFetched());
  }

  Future<void> _fetchChats(
    ChatFetched event,
    Emitter<ChatState> emitter,
  ) async {
    try {
      final chats = await _chatRepository.fetchChats('id');
      emitter(ChatSuccessful(chats: chats));
    } catch (e) {
      emitter(ChatFailure(error: e.toString()));
    }
  }
}
