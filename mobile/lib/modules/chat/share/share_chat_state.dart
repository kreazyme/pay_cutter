part of 'share_chat_bloc.dart';

abstract class ShareChatState extends Equatable {
  const ShareChatState({
    required this.status,
    this.error,
    this.url,
  });

  final HandleStatus status;
  final String? error;
  final String? url;

  @override
  List<Object?> get props => [
        status,
        error,
        url,
      ];
}

class ShareChatInitial extends ShareChatState {
  const ShareChatInitial() : super(status: HandleStatus.loading);

  @override
  List<Object?> get props => [];
}

class ShareChatSuccess extends ShareChatState {
  const ShareChatSuccess({
    required String url,
  }) : super(status: HandleStatus.success, url: url);

  @override
  List<Object?> get props => [url];
}

class ShareChatFailure extends ShareChatState {
  const ShareChatFailure({
    required String error,
  }) : super(status: HandleStatus.error, error: error);

  @override
  List<Object?> get props => [error];
}
