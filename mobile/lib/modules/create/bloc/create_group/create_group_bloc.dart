import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';

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

  Future<void> _submitCreate(
    CreateGroupSubmit event,
    Emitter<CreateGroupState> emitter,
  ) async {
    try {
      GroupModel result = await _groupRepository.createGroup(
        event.name,
      );
      emitter(CreateGroupSuccess(
        group: result,
      ));
    } catch (e) {
      emitter(CreateGroupFailure(error: e.toString()));
    }
  }
}
