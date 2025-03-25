import 'package:your_app/services/api_service.dart';
import 'package:your_app/models/user/user_model.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiService.get('/api/user/all');
    return (response as List).map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel> getUserById(String userId) async {
    final response = await _apiService.get('/api/user', params: {'id': userId});
    return UserModel.fromJson(response);
  }

  Future<UserModel> getUserByManv(String manv) async {
    final response = await _apiService.get('/api/user/manv', params: {'manv': manv});
    return UserModel.fromJson(response);
  }

  Future<void> createUser(UserModel user) async {
    await _apiService.post('/api/user', data: user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _apiService.put('/api/user/${user.idUser}', data: user.toJson());
  }

  Future<void> deleteUser(String userId) async {
    await _apiService.delete('/api/user', params: {'id': userId});
  }
}
