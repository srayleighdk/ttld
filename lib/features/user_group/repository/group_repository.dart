import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/core/repositories/base_repository.dart';
import 'package:ttld/features/user_group/models/group.dart';
import 'package:ttld/repositories/user/user_repository.dart';

class GroupRepository extends BaseRepository {
  final UserRepository userRepository;

  GroupRepository({required this.userRepository});
  Future<List<Group>> getGroups() async {
    return await safeApiCall(() async {
      final response = await dio.get(ApiEndpoints.groups);
      if (response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        final List<dynamic> groupsJson = response.data['data'];
        List<Group> groups =
            groupsJson.map((json) => Group.fromJson(json)).toList();

        // Fetch users for each group
        for (int i = 0; i < groups.length; i++) {
          final users =
              await userRepository.getAllUsers(groupId: groups[i].idUserGroup);
          groups[i] = groups[i].copyWith(users: users);
        }

        return groups;
      } else {
        throw Exception("Unexpected API response format");
      }
    });
  }

  Future<bool> createGroup(Group group) async {
    return await safeApiCall(() async {
      await dio.post(ApiEndpoints.groups, data: group.toJson());
      // Return true on success (no exception thrown)
      return true;
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
