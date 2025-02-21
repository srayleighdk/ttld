import 'package:dio/dio.dart';

class DanhMucKcnApiService {
  final Dio _dio;

  DanhMucKcnApiService(this._dio);

  Future<Response> getKCN(String matinh) async {
    return await _dio.get('/danhmuc/KCN', queryParameters: {'matinh': matinh});
  }
}
