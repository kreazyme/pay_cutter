part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  final HandleStatus status;
  final List<ChatModel>? chats;
  final String? error;

  const ChatState({
    required this.status,
    this.chats,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        chats,
        error,
      ];
}

class ChatLoading extends ChatState {
  const ChatLoading()
      : super(
          status: HandleStatus.loading,
        );
}

class ChatInitial extends ChatState {
  const ChatInitial()
      : super(
          status: HandleStatus.initial,
          chats: const [],
        );
}

class ChatSuccessful extends ChatState {
  const ChatSuccessful({
    required List<ChatModel> chats,
  }) : super(
          status: HandleStatus.success,
          chats: chats,
        );
}

class ChatFailure extends ChatState {
  const ChatFailure({
    required String error,
  }) : super(
          status: HandleStatus.error,
          error: error,
        );
}
