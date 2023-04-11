import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scan.event.dart';
part 'scan.state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(const ScanState.initial()) {
    on<ScanStarted>(_getLoginInfo);
    add(const ScanStarted());
  }

  Future<void> _getLoginInfo(
    ScanStarted event,
    Emitter<ScanState> emitter,
  ) async {}
}
