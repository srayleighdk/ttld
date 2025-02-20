import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';

class ThonApiService {
  final Dio _dio = Dio();

  Future<Response> getThon() async {
    try {
      final response = await _dio.get(ApiEndpoints.thon);
      return response;
    } catch (e) {
      throw Exception('Failed to get thon: $e');
    }
  }

  Future<Response> addThon(dynamic data) async {
    try {
      final response = await _dio.post(ApiEndpoints.thon,  data);
      return response;
    } catch (e) {
      throw Exception('Failed to add thon: $e');
    }
  }

  Future<Response> editThon(dynamic data) async {
    try {
      final response = await _dio.put(ApiEndpoints.thon,  data);
      return response;
    } catch (e) {
      throw Exception('Failed to edit thon: $e');
    }
  }

  Future<Response> deleteThon(dynamic id) async {
    try {
      final response = await _dio.delete(ApiEndpoints.thon,  {'id': id});
      return response;
    } catch (e) {
      throw Exception('Failed to delete thon: $e');
    }
  }
}
