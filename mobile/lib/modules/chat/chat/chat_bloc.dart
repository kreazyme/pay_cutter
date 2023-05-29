import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ExpenseRepository _expenseRepository;
  final int _groupId;

  ChatBloc({
    required ExpenseRepository expenseRepository,
    required int groupId,
  })  : _expenseRepository = expenseRepository,
        _groupId = groupId,
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
      final expenses = await _expenseRepository.getExpenseByGroupId(_groupId);
      emitter(ChatSuccessful(expenses: expenses));
    } catch (e) {
      emitter(ChatFailure(error: e.toString()));
    }
  }
}
