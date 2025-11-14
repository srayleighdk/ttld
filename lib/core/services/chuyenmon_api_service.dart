import 'package:dio/dio.dart';
import 'package:ttld/models/chuyenmon/chuyenmon.dart';

class ChuyenMonApiService {
  final Dio _dio;

  ChuyenMonApiService(this._dio); // Inject the Dio instance

  Future<List<ChuyenMon>> getChuyenMons() async {
    try {
      final response = await _dio.get('/common/chuyen-mon');
      if (response.statusCode == 200) {
        // Handle both array response and {data: [...]} response
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is List
            ? responseData
            : (responseData['data'] as List<dynamic>);
        return data.map((json) => ChuyenMon.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load ChuyenMons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching ChuyenMons: $e');
    }
  }

  Future<ChuyenMon> createChuyenMon(ChuyenMon chuyenMon) async {
    try {
      final response =
          await _dio.post('/tblDmChuyenMon', data: chuyenMon.toJson());
      if (response.statusCode == 201) {
        return ChuyenMon.fromJson(response.data);
      } else {
        throw Exception('Failed to create ChuyenMon: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating ChuyenMon: $e');
    }
  }

  Future<ChuyenMon> updateChuyenMon(int id, ChuyenMon chuyenMon) async {
    try {
      final response =
          await _dio.put('/tblDmChuyenMon/$id', data: chuyenMon.toJson());
      if (response.statusCode == 200) {
        return ChuyenMon.fromJson(response.data);
      } else {
        throw Exception('Failed to update ChuyenMon: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating ChuyenMon: $e');
    }
  }

  Future<void> deleteChuyenMon(int id) async {
    try {
      final response = await _dio.delete('/tblDmChuyenMon/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete ChuyenMon: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting ChuyenMon: $e');
    }
  }
}
