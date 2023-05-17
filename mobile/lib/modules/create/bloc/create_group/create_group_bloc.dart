import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/dto/group.dto.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final GroupRepository _groupRepository;
  CreateGroupBloc({
    required GroupRepository groupRepository,
  })  : _groupRepository = groupRepository,
        super(const CreateGroupInitial()) {
    on<CreateGroupSubmit>(_submitCreate);
  }

  final UserRepo _userRepo = getIt.get<UserRepo>();

  Future<void> _submitCreate(
    CreateGroupSubmit event,
    Emitter<CreateGroupState> emitter,
  ) async {
    try {
      debugPrint('osijfosi');
      emitter(const CreateGroupLoading());
      final userId = (await _userRepo.getUser()).userID;
      debugPrint('osijfosi $userId');
      GroupModel result = await _groupRepository.createGroup(GroupDTO(
        id: userId.toString(),
        name: event.name,
      ));
      emitter(CreateGroupSuccess(
        group: result,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emitter(CreateGroupFailure(error: e.toString()));
    }
  }
}
