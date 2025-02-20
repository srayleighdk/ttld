import 'package:dio/dio.dart';

class DanTocApiService {
  final Dio _dio;

  DanTocApiService(this._dio);

  Future<Response> getDanToc() async {
    return await _dio.get('/api/danhmuc/dan-toc');
  }

  Future<Response> postDanToc(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/dan-toc', data);
  }

  Future<Response> putDanToc(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/dan-toc', data);
  }

  Future<void> deleteDanToc(String id) async {
    await _dio.delete('/api/danhmuc/dan-toc/$id');
  }
}
