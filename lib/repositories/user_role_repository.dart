import 'package:ttld/models/permission_role/permission_role.dart';
import 'package:ttld/services/user_role_service.dart';

class UserRoleRepository {
  final UserRoleService _service;

  UserRoleRepository(this._service);

  Future<List<PermissionRole>> fetchRoles(userName) async {
    return await _service.getRoles(userName);
  }

  Future<void> updateUserRoles(
      List<PermissionRole> roles, String userName) async {
    await _service.updateRoles(roles, userName);
  }
}
