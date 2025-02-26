import 'package:dio/dio.dart';

class TinhThanhApiService {
  final Dio _dio;

  TinhThanhApiService(this._dio);

  Future<Response> getTinhThanh() async {
    return await _dio.get('/api/common/tinhthanh');
  }
}
