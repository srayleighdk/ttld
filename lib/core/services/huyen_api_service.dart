import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';

class HuyenApiService {
  final Dio _dio;

  HuyenApiService(this._dio); // Inject the Dio instance

  // Huyen
  Future<dynamic> getHuyen() async {
    try {
      final response = await _dio.get(ApiEndpoints.huyen);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postHuyen(dynamic data) async {
    try {
      final response = await _dio.post(ApiEndpoints.huyen, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putHuyen(dynamic data) async {
    try {
      final response = await _dio.put(ApiEndpoints.huyen, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteHuyen(String id) async {
    try {
      final response =
          await _dio.delete(ApiEndpoints.huyen, queryParameters: {'id': id});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
