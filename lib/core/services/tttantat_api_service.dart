import 'package:dio/dio.dart';
import 'package:ttld/models/tttantat/tttantat.dart';

class TinhTrangTanTatApiService {
  final Dio _dio;

  TinhTrangTanTatApiService(this._dio); // Inject the Dio instance

  Future<List<TinhTrangTanTat>> getTinhTrangTanTats() async {
    try {
      final response = await _dio.get('/tblDmTinhTrangTanTat');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => TinhTrangTanTat.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load TinhTrangTanTats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching TinhTrangTanTats: $e');
    }
  }

  Future<TinhTrangTanTat> createTinhTrangTanTat(
      TinhTrangTanTat tinhTrangTanTat) async {
    try {
      final response = await _dio.post('/tblDmTinhTrangTanTat',
          data: tinhTrangTanTat.toJson());
      if (response.statusCode == 201) {
        return TinhTrangTanTat.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to create TinhTrangTanTat: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating TinhTrangTanTat: $e');
    }
  }

  Future<TinhTrangTanTat> updateTinhTrangTanTat(
      int id, TinhTrangTanTat tinhTrangTanTat) async {
    try {
      final response = await _dio.put('/tblDmTinhTrangTanTat/$id',
          data: tinhTrangTanTat.toJson());
      if (response.statusCode == 200) {
        return TinhTrangTanTat.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to update TinhTrangTanTat: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating TinhTrangTanTat: $e');
    }
  }

  Future<void> deleteTinhTrangTanTat(int id) async {
    try {
      final response = await _dio.delete('/tblDmTinhTrangTanTat/$id');
      if (response.statusCode != 204) {
        throw Exception(
            'Failed to delete TinhTrangTanTat: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting TinhTrangTanTat: $e');
    }
  }
}
