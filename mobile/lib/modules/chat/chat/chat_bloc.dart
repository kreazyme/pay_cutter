import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/expense_repo.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ExpenseRepository _expenseRepository;
  final GroupRepository _groupRepo;
  final GroupModel _group;

  ChatBloc({
    required ExpenseRepository expenseRepository,
    required GroupModel group,
    required GroupRepository groupRepo,
  })  : _expenseRepository = expenseRepository,
        _group = group,
        _groupRepo = groupRepo,
        super(const ChatInitial()) {
    on<ChatStarted>(_started);
    on<ChatFetched>(_fetchChats);
    on<ChatAddExpense>(_addExpense);
    on<ChatDeleteExpense>(_deleteExpense);

    add(const ChatStarted());
  }

  Future<void> _started(
    ChatStarted event,
    Emitter<ChatState> emitter,
  ) async {
    emitter(const ChatLoading());
    add(const ChatFetched());
  }

  Future<void> _deleteExpense(
    ChatDeleteExpense event,
    Emitter<ChatState> emitter,
  ) async {
    try {
      await _expenseRepository.deleteExpense(event.id);
      final expenses = state.expenses.where((e) => e.id != event.id).toList();
      emitter(
        ChatSuccessful(
          expenses: expenses,
          group: state.group!,
        ),
      );
    } catch (e) {
      emitter(ChatFailure(error: e.toString()));
    }
  }

  Future<void> _fetchChats(
    ChatFetched event,
    Emitter<ChatState> emitter,
  ) async {
    try {
      var expenses = await _expenseRepository.getExpenseByGroupId(_group.id);
      expenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final GroupModel group = await _groupRepo.getDetailGroup(_group.id);
      emitter(ChatSuccessful(
        expenses: expenses,
        group: group,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emitter(ChatFailure(error: e.toString()));
    }
  }

  Future<void> _addExpense(
    ChatAddExpense event,
    Emitter<ChatState> emitter,
  ) async {
    emitter(
      ChatSuccessful(
        expenses: [
          event.expense,
          ...state.expenses,
        ],
        group: state.group!,
      ),
    );
  }
}
