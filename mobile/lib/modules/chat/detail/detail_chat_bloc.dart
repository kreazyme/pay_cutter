import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_chat_event.dart';
part 'detail_chat_state.dart';

class DetailChatBloc extends Bloc<DetailChatEvent, DetailChatState> {
  DetailChatBloc() : super(DetailChatInitial()) {
    on<DetailChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
