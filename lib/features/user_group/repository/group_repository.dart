import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/core/repositories/base_repository.dart';
import 'package:ttld/features/user_group/models/group.dart';

class GroupRepository extends BaseRepository {
  Future<List<Group>> getGroups() async {
    return await safeApiCall(() async {
      final response = await dio.get(ApiEndpoints.groups);
      if (response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        final List<dynamic> groupsJson = response.data['data'];
        return groupsJson.map((json) => Group.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected API response format");
      }
    });
  }

  Future<Group> createGroup(String name, String? parentId) async {
    return await safeApiCall(() async {
      final response = await dio.post(ApiEndpoints.groups, data: {
        "name": name,
        "parentId": parentId,
      });
      return Group.fromJson(response.data);
    });
  }

  Future<Group> updateGroup(String id, String name, String? description) async {
    return await safeApiCall(() async {
      final response = await dio.put('${ApiEndpoints.groups}/group/$id', data: {
        "name": name,
        "description": description,
      });
      return Group.fromJson(response.data);
    });
  }

  Future<void> deleteGroup(String id) async {
    await safeApiCall(() async {
      await dio.delete('/user/group/$id');
    });
  }
}
