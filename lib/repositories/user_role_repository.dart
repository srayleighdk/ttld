import '../services/user_role_service.dart';
import '../model/permission_role/permission_role.dart';

class UserRoleRepository {
  final UserRoleService _service;

  UserRoleRepository(this._service);

  Future<List<PermissionRole>> fetchRoles() async {
    return await _service.getRoles();
  }

  Future<void> updateUserRoles(List<PermissionRole> roles) async {
    await _service.updateRoles(roles);
  }
}
