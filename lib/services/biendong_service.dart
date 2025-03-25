import 'package:dio/dio.dart';
import 'package:ttld/models/nhanvien/nhanvien_model.dart';

class BienDongService {
  final Dio _dio;

  BienDongService(this._dio);

  Future<Response> getBienDongList(String? userId) async {
    return _dio
        .get('/tttt/bien-dong-list', queryParameters: {'userId': userId});
  }

  Future<Response> createBienDong(NhanVien bienDong) async {
    return _dio.post('/tttt/bien-dong', data: bienDong.toJson());
  }

  Future<Response> updateBienDong(NhanVien bienDong) async {
    return _dio.put('/tttt/bien-dong', data: bienDong.toJson());
  }

  Future<Response> deleteBienDong(String id) async {
    return _dio.delete('/tttt/bien-dong', data: {'id': id});
  }
}
