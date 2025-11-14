import 'package:dio/dio.dart';

class VeTinhApiService {
  final Dio _dio;

  VeTinhApiService(this._dio);

  Future<Response> getAll({
    int? page,
    int? limit,
    String? search,
  }) async {
    return await _dio.get('/danhmuc/vetinh', queryParameters: {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (search != null && search.isNotEmpty) 'search': search,
    });
  }

  Future<Response> getById(String id) async {
    return await _dio.get('/danhmuc/vetinh/by-id', queryParameters: {'id': id});
  }

  Future<Response> create(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/vetinh', data: data);
  }

  Future<Response> update(String id, Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/vetinh', queryParameters: {'id': id}, data: data);
  }

  Future<Response> delete(String id) async {
    return await _dio.delete('/danhmuc/vetinh', queryParameters: {'id': id});
  }
}
