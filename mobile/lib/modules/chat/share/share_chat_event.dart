part of 'share_chat_bloc.dart';

abstract class ShareChatEvent extends Equatable {
  const ShareChatEvent();

  @override
  List<Object> get props => [];
}

class ShareChatUrlGet extends ShareChatEvent {
  const ShareChatUrlGet({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [
        id,
      ];
}
