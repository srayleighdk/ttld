import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuyendungtrongnld/repositories/user_role_repository.dart';
import '../model/permission_role/permission_role.dart';

part 'user_role_event.dart';
part 'user_role_state.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  final UserRoleRepository _repository;

  UserRoleBloc(this._repository) : super(UserRoleInitial()) {
    on<LoadUserRoles>(_onLoadUserRoles);
    on<UpdateUserRoles>(_onUpdateUserRoles);
  }

  Future<void> _onLoadUserRoles(
    LoadUserRoles event,
    Emitter<UserRoleState> emit,
  ) async {
    emit(UserRoleLoading());
    try {
      final roles = await _repository.fetchRoles();
      emit(UserRoleLoaded(roles: roles));
    } catch (e) {
      emit(UserRoleError(message: e.toString()));
    }
  }

  Future<void> _onUpdateUserRoles(
    UpdateUserRoles event,
    Emitter<UserRoleState> emit,
  ) async {
    emit(UserRoleLoading());
    try {
      await _repository.updateUserRoles(event.roles);
      final updatedRoles = await _repository.fetchRoles();
      emit(UserRoleUpdated(roles: updatedRoles));
    } catch (e) {
      emit(UserRoleError(message: e.toString()));
    }
  }
}
