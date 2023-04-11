import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    on<ProfileStarted>(_onProfileStarted);
  }

  Future<void> _onProfileStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {}
}
