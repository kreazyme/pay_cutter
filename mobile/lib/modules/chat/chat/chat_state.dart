part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  final HandleStatus status;
  final List<ExpenseModel> expenses;
  final String? error;
  final GroupModel? group;

  const ChatState({
    required this.status,
    required this.expenses,
    this.error,
    this.group,
  });

  @override
  List<Object?> get props => [
        status,
        expenses,
        error,
        group,
      ];
}

class ChatLoading extends ChatState {
  const ChatLoading()
      : super(
          status: HandleStatus.loading,
          expenses: const [],
        );
}

class ChatInitial extends ChatState {
  const ChatInitial()
      : super(
          status: HandleStatus.initial,
          expenses: const [],
        );
}

class ChatSuccessful extends ChatState {
  const ChatSuccessful({
    required List<ExpenseModel> expenses,
    required GroupModel group,
  }) : super(
          status: HandleStatus.success,
          expenses: expenses,
          group: group,
        );
}

class ChatFailure extends ChatState {
  const ChatFailure({
    required String error,
  }) : super(
          status: HandleStatus.error,
          error: error,
          expenses: const [],
        );
}
