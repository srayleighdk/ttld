import 'package:dio/dio.dart';
import '../models/chinhsachluong/chinhsachluong_model.dart';

class ChinhSachLuongApiService {
  final Dio _dio;

  ChinhSachLuongApiService(this._dio);

  Future<List<ChinhSachLuong>> getChinhSachLuongs() async {
    try {
      final response = await _dio.get('/api/chinh-sach-luong');
      return (response.data as List).map((e) => ChinhSachLuong.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load chinh sach luong: ${e.message}');
    }
  }

  Future<ChinhSachLuong> createChinhSachLuong(ChinhSachLuong csl) async {
    try {
      final response = await _dio.post(
        '/api/chinh-sach-luong',
        data: csl.toJson(),
      );
      return ChinhSachLuong.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create chinh sach luong: ${e.message}');
    }
  }

  Future<ChinhSachLuong> updateChinhSachLuong(ChinhSachLuong csl) async {
    try {
      final response = await _dio.put(
        '/api/chinh-sach-luong',
        data: csl.toJson(),
      );
      return ChinhSachLuong.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update chinh sach luong: ${e.message}');
    }
  }

  Future<void> deleteChinhSachLuong(int id) async {
    try {
      await _dio.delete(
        '/api/chinh-sach-luong',
        data: {'Id': id},
      );
    } on DioException catch (e) {
      throw Exception('Failed to delete chinh sach luong: ${e.message}');
    }
  }
}
