import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';

class HosoXkldApiService {
  final Dio _dio;

  HosoXkldApiService(this._dio);

  Future<Map<String, dynamic>> getHosoXkldList({
    String? idUv,
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.hosoXkld,
        queryParameters: {
          if (idUv != null) 'idUv': idUv,
          'limit': limit,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final int total = response.data['total'] ?? 0;

        return {
          'data': data.map((json) => HosoXKLDModel.fromJson(json)).toList(),
          'total': total,
        };
      } else {
        throw Exception('Failed to load hồ sơ XKLD: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load hồ sơ XKLD: $e');
    }
  }

  Future<HosoXKLDModel> getHosoXkldById(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.hosoXkld}/$id');
      if (response.statusCode == 200) {
        return HosoXKLDModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load hồ sơ XKLD: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load hồ sơ XKLD: $e');
    }
  }

  Future<HosoXKLDModel> createHosoXkld(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.hosoXkld,
        data: data,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return HosoXKLDModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create hồ sơ XKLD: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create hồ sơ XKLD: $e');
    }
  }

  Future<HosoXKLDModel> updateHosoXkld(
      String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.hosoXkld}/$id',
        data: data,
      );
      if (response.statusCode == 200) {
        return HosoXKLDModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update hồ sơ XKLD: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update hồ sơ XKLD: $e');
    }
  }

  Future<void> deleteHosoXkld(String id) async {
    try {
      final response = await _dio.delete('${ApiEndpoints.hosoXkld}/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete hồ sơ XKLD: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete hồ sơ XKLD: $e');
    }
  }
}
