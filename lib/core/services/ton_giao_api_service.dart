import 'package:dio/dio.dart';

class TonGiaoApiService {
  final Dio _dio;

  TonGiaoApiService(this._dio);

  Future<Response> getTonGiao() async {
    return await _dio.get('/danhmuc/ton-giao');
  }

  Future<Response> postTonGiao(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/ton-giao', data: data);
  }

  Future<Response> putTonGiao(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/ton-giao', data: data);
  }

  Future<void> deleteTonGiao(String id) async {
    await _dio.delete('/danhmuc/ton-giao', queryParameters: {'id': id});
  }
}
