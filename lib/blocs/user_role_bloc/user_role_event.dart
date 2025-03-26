part of 'user_role_bloc.dart';
part 'user_role_event.freezed.dart';

@freezed
class UserRoleEvent with _$UserRoleEvent {
  const factory UserRoleEvent.loadRoles(String userName) = LoadUserRoles;
  const factory UserRoleEvent.updateRoles(List<PermissionRole> roles) =
      UpdateUserRoles;
}
