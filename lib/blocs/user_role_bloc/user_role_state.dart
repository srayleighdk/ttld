part of 'user_role_bloc.dart';

@freezed
class UserRoleState with _$UserRoleState {
  const factory UserRoleState.initial() = UserRoleInitial;
  const factory UserRoleState.loading() = UserRoleLoading;
  const factory UserRoleState.loaded({required List<PermissionRole> roles}) = UserRoleLoaded;
  const factory UserRoleState.updated({required List<PermissionRole> roles}) = UserRoleUpdated;
  const factory UserRoleState.error({required String message}) = UserRoleError;
}
