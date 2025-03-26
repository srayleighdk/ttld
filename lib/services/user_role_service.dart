import 'package:dio/dio.dart';
import 'package:ttld/models/permission_role/permission_role.dart';

class UserRoleService {
  final Dio _dio;

  UserRoleService(this._dio);

  Future<List<PermissionRole>> getRoles(String userName) async {
    final response = await _dio.get('/user/user-roles', queryParameters: {
      'user': userName,
    });
    return (response.data['data'] as List)
        .map((e) => PermissionRole.fromJson(e))
        .toList();
  }

  Future<void> updateRoles(List<PermissionRole> roles, String userName) async {
    final requestBody = {
      'user': userName,
      'roles': roles.map((e) => e.toJson()).toList(),
    };
    await _dio.post('/user/user-roles', data: requestBody);
  }
}
