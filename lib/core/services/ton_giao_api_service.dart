import 'package:dio/dio.dart';

class TonGiaoApiService {
  final Dio _dio;

  TonGiaoApiService(this._dio);

  Future<Response> getTonGiao() async {
    return await _dio.get('/api/danhmuc/ton-giao');
  }

  Future<Response> postTonGiao(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/ton-giao', data);
  }

  Future<Response> putTonGiao(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/ton-giao', data);
  }

  Future<void> deleteTonGiao(String id) async {
    await _dio.delete('/api/danhmuc/ton-giao/$id');
  }
}
