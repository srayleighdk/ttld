import 'package:dio/dio.dart';
import 'package:ttld/models/muc_luong_mm.dart'; // Replace with your actual import

class MucLuongApiService {
  final Dio dio;

  MucLuongApiService(this.dio);

  Future<Response> getMucLuongs() async {
    return await dio.get('/bo-sung/muc-luong');

  }

  Future<Response> createMucLuong(MucLuongMM mucLuong) async {
    return await dio.post('/bo-sung/muc-luong', data: mucLuong.toJson());

  }

  Future<Response> updateMucLuong(MucLuongMM mucLuong) async {
    return await dio.put('/bo-sung/muc-luong', data: mucLuong.toJson());
  }

  Future<void> deleteMucLuong(int id) async {
    await dio.delete('/bo-sung/muc-luong', queryParameters: {'id': id});
  }
}

