import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepo _userRepo;
  final AuthenRepo _authenRepo;

  ProfileBloc({
    required UserRepo userRepo,
    required AuthenRepo authenRepo,
  })  : _userRepo = userRepo,
        _authenRepo = authenRepo,
        super(const ProfileState.initial()) {
    on<ProfileStarted>(_onProfileStarted);
    on<ProfileLogout>(_onLogout);

    add(ProfileStarted());
  }

  Future<void> _onProfileStarted(
    ProfileStarted event,
    Emitter<ProfileState> emitter,
  ) async {
    try {
      emitter(const ProfileState.loading());
      final UserModel user = await _userRepo.getUser();
      emitter(ProfileState.success(user));
    } catch (e) {
      emitter(const ProfileState.error());
    }
  }

  Future<void> _onLogout(
    ProfileLogout event,
    Emitter<ProfileState> emitter,
  ) async {
    try {
      emitter(const ProfileState.loading());
      await _authenRepo.logout();
      await _userRepo.deleteToken();
      emitter(const ProfileLogouted());
    } catch (e) {
      emitter(const ProfileState.error());
    }
  }
}
