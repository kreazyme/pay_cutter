part of 'detail_chat_bloc.dart';

abstract class DetailChatState extends Equatable {
  const DetailChatState();

  @override
  List<Object> get props => [];
}

class DetailChatInitial extends DetailChatState {}

class DetailChatFileSaved extends DetailChatState {
  final String filePath;
  const DetailChatFileSaved({
    required this.filePath,
  });
}
