import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'core.event.dart';
part 'core.state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  CoreBloc()
      : super(
          const CoreState.initial(),
        ) {
    on<CoreBottomChange>(_onChangeIndexBottom);
  }
  Future<void> _onChangeIndexBottom(
    CoreBottomChange event,
    Emitter<CoreState> emit,
  ) async {
    emit(
      CoreState(event.index),
    );
  }
}
