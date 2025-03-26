part of 'user_role_bloc.dart';

@freezed
class UserRoleEvent with _$UserRoleEvent {
  const factory UserRoleEvent.loadRoles(String userName) = LoadUserRoles;
  const factory UserRoleEvent.updateRoles(List<PermissionRole> roles) =
      UpdateUserRoles;
}
