part of 'detail_chat_bloc.dart';

abstract class DetailChatState extends Equatable {
  final HandleStatus? sendPushStatus;

  const DetailChatState({
    required this.sendPushStatus,
  });

  @override
  List<Object> get props => [];
}

class DetailChatInitial extends DetailChatState {
  const DetailChatInitial()
      : super(
          sendPushStatus: HandleStatus.initial,
        );
}

class DetailChatFileSaved extends DetailChatState {
  final String filePath;
  final HandleStatus sendPushStatus;
  const DetailChatFileSaved({
    required this.filePath,
    required this.sendPushStatus,
  }) : super(
          sendPushStatus: sendPushStatus,
        );
}

class DetailChatChangePushStatus extends DetailChatState {
  final HandleStatus sendPushStatus;
  const DetailChatChangePushStatus({
    required this.sendPushStatus,
  }) : super(
          sendPushStatus: sendPushStatus,
        );
}
