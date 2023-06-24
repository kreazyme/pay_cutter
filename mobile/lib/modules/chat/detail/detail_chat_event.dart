part of 'detail_chat_bloc.dart';

abstract class DetailChatEvent extends Equatable {
  const DetailChatEvent();

  @override
  List<Object> get props => [];
}

class DetailChatSaveFile extends DetailChatEvent {
  final String groupName;
  final List<ExpenseModel> expenses;
  const DetailChatSaveFile({
    required this.groupName,
    required this.expenses,
  });
}
