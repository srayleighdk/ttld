import 'package:dio/dio.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';

class M02TT11ApiService {
  final Dio _dio;

  M02TT11ApiService(this._dio);

  /// Get list of M02TT11 registrations for a user
  Future<List<M02TT11>> getM02TT11List(String userId) async {
    const String apiUrl = '/tttt/m02tt11';
    final response = await _dio.get(
      apiUrl,
      queryParameters: {'iduv': userId},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final List<dynamic> data = responseData['data'] as List<dynamic>;
      return data.map((json) => M02TT11.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load M02TT11 list: ${response.statusCode}');
    }
  }

  /// Get a single M02TT11 by ID
  Future<M02TT11> getM02TT11ById(String id) async {
    final String apiUrl = '/tttt/m02tt11/$id';
    final response = await _dio.get(apiUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      return M02TT11.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to load M02TT11: ${response.statusCode}');
    }
  }

  /// Create a new M02TT11 registration
  Future<M02TT11> createM02TT11(M02TT11 data) async {
    const String apiUrl = '/tttt/m02tt11';
    final response = await _dio.post(
      apiUrl,
      data: data.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      return M02TT11.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to create M02TT11: ${response.statusCode}');
    }
  }

  /// Update an existing M02TT11 registration
  Future<M02TT11> updateM02TT11(String id, M02TT11 data) async {
    final String apiUrl = '/tttt/m02tt11/$id';
    final response = await _dio.put(
      apiUrl,
      data: data.toJson(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      return M02TT11.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to update M02TT11: ${response.statusCode}');
    }
  }

  /// Delete an M02TT11 registration
  Future<void> deleteM02TT11(String id) async {
    const String apiUrl = '/tttt/m02tt11';
    final response = await _dio.delete(
      apiUrl,
      queryParameters: {'id': id},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete M02TT11: ${response.statusCode}');
    }
  }
}
