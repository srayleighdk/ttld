import 'package:dio/dio.dart';
import 'package:ttld/models/biendong_model.dart';

class BienDongService {
  final Dio _dio;

  BienDongService(this._dio);

  Future<Response> getBienDongList(String? userId) async {
    return _dio.get('/api/tttt/bien-dong-list', 
      queryParameters: {'userId': userId}
    );
  }

  Future<Response> createBienDong(BienDong bienDong) async {
    return _dio.post('/api/tttt/bien-dong', data: bienDong.toJson());
  }

  Future<Response> updateBienDong(BienDong bienDong) async {
    return _dio.put('/api/tttt/bien-dong', data: bienDong.toJson());
  }

  Future<Response> deleteBienDong(String id) async {
    return _dio.delete('/api/tttt/bien-dong', 
      data: {'id': id}
    );
  }
}
