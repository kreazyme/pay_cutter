part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatFetched extends ChatEvent {
  const ChatFetched();

  @override
  List<Object> get props => [];
}

class ChatStarted extends ChatEvent {
  const ChatStarted();

  @override
  List<Object> get props => [];
}

class ChatSent extends ChatEvent {
  const ChatSent({required this.content});

  final String content;

  @override
  List<Object> get props => [content];
}

class ChatAddExpense extends ChatEvent {
  const ChatAddExpense({required this.expense});

  final ExpenseModel expense;

  @override
  List<Object> get props => [
        expense,
      ];
}
