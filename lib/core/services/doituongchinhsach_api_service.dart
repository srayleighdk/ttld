import 'package:dio/dio.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';

class DoiTuongChinhSachApiService {
  final Dio _dio;

  DoiTuongChinhSachApiService(this._dio); // Inject the Dio instance

  Future<List<DoiTuongChinhSach>> getDoiTuongChinhSachs() async {
    try {
      final response = await _dio.get('/tblDmDoiTuongChinhSach');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => DoiTuongChinhSach.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load DoiTuongChinhSachs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching DoiTuongChinhSachs: $e');
    }
  }

  Future<DoiTuongChinhSach> createDoiTuongChinhSach(
      DoiTuongChinhSach doiTuongChinhSach) async {
    try {
      final response = await _dio.post('/tblDmDoiTuongChinhSach',
          data: doiTuongChinhSach.toJson());
      if (response.statusCode == 201) {
        return DoiTuongChinhSach.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to create DoiTuongChinhSach: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating DoiTuongChinhSach: $e');
    }
  }

  Future<DoiTuongChinhSach> updateDoiTuongChinhSach(
      int id, DoiTuongChinhSach doiTuongChinhSach) async {
    try {
      final response = await _dio.put('/tblDmDoiTuongChinhSach/$id',
          data: doiTuongChinhSach.toJson());
      if (response.statusCode == 200) {
        return DoiTuongChinhSach.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to update DoiTuongChinhSach: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating DoiTuongChinhSach: $e');
    }
  }

  Future<void> deleteDoiTuongChinhSach(int id) async {
    try {
      final response = await _dio.delete('/tblDmDoiTuongChinhSach/$id');
      if (response.statusCode != 204) {
        throw Exception(
            'Failed to delete DoiTuongChinhSach: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting DoiTuongChinhSach: $e');
    }
  }
}
