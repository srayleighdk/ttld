class UserRepository {
  final ApiClient _apiClient;

  UserRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiClient.get('/api/user/all');
    return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel> getUserById(String userId) async {
    final response =
        await _apiClient.get('/api/user', queryParameters: {'id': userId});
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getUserByManv(String manv) async {
    final response =
        await _apiClient.get('/api/user/manv', queryParameters: {'manv': manv});
    return UserModel.fromJson(response.data);
  }

  Future<void> createUser(UserModel user) async {
    await _apiClient.post('/api/user', data: user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _apiClient.put('/api/user/${user.idUser}', data: user.toJson());
  }

  Future<void> deleteUser(String userId) async {
    await _apiClient.delete('/api/user/$userId');
  }
}
