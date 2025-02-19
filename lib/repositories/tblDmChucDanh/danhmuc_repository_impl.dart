import 'package:dio/dio.dart';
import 'package:ttld/models/danhmuc/danhmuc.dart';
import 'package:ttld/repositories/tblDmChucDanh/danhmuc_repository.dart';

class DanhMucRepositoryImpl implements DanhMucRepository {
  final Dio dio; // Declare the Dio dependency

  DanhMucRepositoryImpl(this.dio); // Constructor accepting Dio

  @override
  Future<List<DanhMuc>> getDanhMucs() async {
    try {
      final response = await dio.get('/tblDmChucDanh'); // Use the injected dio
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => DanhMuc.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load DanhMucs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching DanhMucs: $e');
    }
  }

  @override
  Future<DanhMuc> createDanhMuc(DanhMuc danhmuc) async {
    try {
      final response = await dio.post('/tblDmChucDanh',
          data: danhmuc.toJson()); // Use injected dio
      if (response.statusCode == 201) {
        return DanhMuc.fromJson(response.data);
      } else {
        throw Exception('Failed to create DanhMuc: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating DanhMuc: $e');
    }
  }

  @override
  Future<DanhMuc> updateDanhMuc(int id, DanhMuc danhmuc) async {
    try {
      final response = await dio.put('/tblDmChucDanh/$id',
          data: danhmuc.toJson()); // Use injected dio
      if (response.statusCode == 200) {
        return DanhMuc.fromJson(response.data);
      } else {
        throw Exception('Failed to update DanhMuc: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating DanhMuc: $e');
    }
  }

  @override
  Future<void> deleteDanhMuc(int id) async {
    try {
      final response =
          await dio.delete('/tblDmChucDanh/$id'); // Use injected dio
      if (response.statusCode != 204) {
        throw Exception('Failed to delete DanhMuc: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting DanhMuc: $e');
    }
  }
}
