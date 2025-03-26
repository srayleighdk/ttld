import 'package:ttld/models/user/user_model.dart';
import 'package:ttld/services/user_api_service.dart';

class UserRepository {
  final UserApiService _userApiService;

  UserRepository({required UserApiService userApiService})
      : _userApiService = userApiService;

  Future<List<UserModel>> getAllUsers() async {
    final response = await _userApiService.getAllUsers();
    return (response.data['data'] as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
  }

  Future<UserModel> getUserById(String userId) async {
    final response = await _userApiService.getUserById(userId);
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getUserByManv(String manv) async {
    final response = await _userApiService.getUserByManv(manv);
    return UserModel.fromJson(response.data);
  }

  Future<void> createUser(UserModel user) async {
    await _userApiService.createUser(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _userApiService.updateUser(user.idUser, user.toJson());
  }

  Future<void> deleteUser(String userId) async {
    await _userApiService.deleteUser(userId);
  }
}
