import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/dky_hoc_nghe/dky_hoc_nghe_model.dart';

class DkyHocNgheApiService {
  final Dio _dio;

  DkyHocNgheApiService(this._dio);

  Future<Map<String, dynamic>> getDkyHocNgheList({
    int? idloai,
    String? idUv,
    String? idHoSo,
    bool? duyetdangky,
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.dkyHocNghe,
        queryParameters: {
          if (idloai != null) 'idloai': idloai,
          if (idUv != null) 'idUv': idUv,
          if (idHoSo != null) 'idHoSo': idHoSo,
          if (duyetdangky != null) 'duyetdangky': duyetdangky,
          'limit': limit,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final int total = response.data['total'] ?? 0;

        return {
          'data': data.map((json) => DkyHocNghe.fromJson(json)).toList(),
          'total': total,
        };
      } else {
        throw Exception(
            'Failed to load đăng ký học nghề: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load đăng ký học nghề: $e');
    }
  }

  Future<DkyHocNghe> getDkyHocNgheById(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.dkyHocNghe}/$id');
      if (response.statusCode == 200) {
        return DkyHocNghe.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to load đăng ký học nghề: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load đăng ký học nghề: $e');
    }
  }

  Future<DkyHocNghe> createDkyHocNghe(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.dkyHocNghe,
        data: data,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return DkyHocNghe.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to create đăng ký học nghề: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create đăng ký học nghề: $e');
    }
  }

  Future<DkyHocNghe> updateDkyHocNghe(
      String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.dkyHocNghe}/$id',
        data: data,
      );
      if (response.statusCode == 200) {
        return DkyHocNghe.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to update đăng ký học nghề: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update đăng ký học nghề: $e');
    }
  }

  Future<void> deleteDkyHocNghe(String id) async {
    try {
      final response = await _dio.delete('${ApiEndpoints.dkyHocNghe}/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
            'Failed to delete đăng ký học nghề: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete đăng ký học nghề: $e');
    }
  }
}
