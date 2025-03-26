import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/models/permission_role/permission_role.dart';
import 'package:ttld/repositories/user_role_repository.dart';

part 'user_role_event.dart';
part 'user_role_state.dart';
part 'user_role_bloc.freezed.dart';

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
      final roles = await _repository.fetchRoles(event.userName);
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
      await _repository.updateUserRoles(event.roles, event.userName);
      final updatedRoles = await _repository.fetchRoles(event.userName);
      emit(UserRoleUpdated(roles: updatedRoles));
    } catch (e) {
      emit(UserRoleError(message: e.toString()));
    }
  }
}
