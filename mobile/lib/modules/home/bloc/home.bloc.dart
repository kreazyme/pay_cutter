import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';

part 'home.event.dart';
part 'home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupRepository _groupRepository;
  HomeBloc({
    required GroupRepository groupRepository,
  })  : _groupRepository = groupRepository,
        super(const HomeState.loading()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeAddGroup>(_addNewGroup);

    add(const HomeStarted());
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emitter,
  ) async {
    try {
      emitter(const HomeState.loading());
      var groups = await _groupRepository.fetchGroups();
      groups.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      emitter(HomeState.success(groups));
    } catch (e) {
      emitter(HomeState.error(e.toString()));
    }
  }

  Future<void> _addNewGroup(
    HomeAddGroup event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(
      HomeState.addGroup(groups: [
        ...state.groups,
        event.group,
      ]),
    );
  }
}
