import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttld/features/user_group/models/group.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;

  GroupBloc({required this.groupRepository}) : super(GroupLoading()) {
    on<LoadGroups>(_onLoadGroups);
    on<CreateGroup>(_onCreateGroup);
    on<UpdateGroup>(_onUpdateGroup);
    on<DeleteGroup>(_onDeleteGroup);
  }

  Future<void> _onLoadGroups(LoadGroups event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    try {
      final groups = await groupRepository.getGroups();
      emit(GroupLoaded(groups));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  Future<void> _onCreateGroup(
      CreateGroup event, Emitter<GroupState> emit) async {
    if (state is GroupLoaded) {
      final currentState = state as GroupLoaded;
      try {
        final newGroup =
            await groupRepository.createGroup(event.name, event.parentId);
        emit(GroupLoaded([...currentState.groups, newGroup]));
      } catch (e) {
        emit(GroupError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateGroup(
      UpdateGroup event, Emitter<GroupState> emit) async {
    if (state is GroupLoaded) {
      final currentState = state as GroupLoaded;
      try {
        final updatedGroup = await groupRepository.updateGroup(
            event.id, event.name, event.description);
        final updatedGroups = currentState.groups
            .map((g) => g.idUserGroup == event.id ? updatedGroup : g)
            .toList();
        emit(GroupLoaded(updatedGroups));
      } catch (e) {
        emit(GroupError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteGroup(
      DeleteGroup event, Emitter<GroupState> emit) async {
    if (state is GroupLoaded) {
      final currentState = state as GroupLoaded;
      try {
        await groupRepository.deleteGroup(event.id);
        final updatedGroups = currentState.groups
            .where((g) => g.idUserGroup != event.id)
            .toList();
        emit(GroupLoaded(updatedGroups));
      } catch (e) {
        emit(GroupError(e.toString()));
      }
    }
  }
}
