import 'package:dio/dio.dart';

class DanTocApiService {
  final Dio _dio;

  DanTocApiService(this._dio);

  Future<Response> getDanToc() async {
    return await _dio.get('/danhmuc/dan-toc');
  }

  Future<Response> postDanToc(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/dan-toc', data:data);
  }

  Future<Response> putDanToc(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/dan-toc', data:data);
  }

  Future<void> deleteDanToc(String id) async {
    await _dio.delete('/danhmuc/dan-toc', queryParameters: {'id': id});
  }
}