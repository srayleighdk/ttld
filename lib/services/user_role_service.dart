import 'package:dio/dio.dart';
import 'package:tuyendungtrongnld/model/permission_role/permission_role.dart';

class UserRoleService {
  final Dio _dio;

  UserRoleService(this._dio);

  Future<List<PermissionRole>> getRoles() async {
    final response = await _dio.get('/api/user/user-roles');
    return (response.data as List)
        .map((e) => PermissionRole.fromJson(e))
        .toList();
  }

  Future<void> updateRoles(List<PermissionRole> roles) async {
    await _dio.post('/api/user/user-roles', 
      data: roles.map((e) => e.toJson()).toList());
  }
}
