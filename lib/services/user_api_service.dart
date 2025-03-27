import 'package:dio/dio.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(this._dio);

  Future<Response> getAllUsers(String? groupId) async {
    if (groupId != null) {
      return _dio.get('/user/all', queryParameters: {'groupId': groupId});
    }
    return _dio.get('/user/all');
  }

  Future<Response> getUserById(String userId) async {
    return _dio.get('/user', queryParameters: {'id': userId});
  }

  Future<Response> getUserByManv(String manv) async {
    return _dio.get('/user/manv', queryParameters: {'manv': manv});
  }

  Future<Response> createUser(Map<String, dynamic> userData) async {
    return _dio.post('/user', data: userData);
  }

  Future<Response> updateUser(
      String userId, Map<String, dynamic> userData) async {
    return _dio.put('/user/$userId', data: userData);
  }

  Future<Response> deleteUser(String userId) async {
    return _dio.delete('/user/$userId');
  }
}
