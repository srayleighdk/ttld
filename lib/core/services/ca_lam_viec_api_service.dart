import 'package:dio/dio.dart';

class CaLamViecApiService {
  final Dio _dio;

  CaLamViecApiService(this._dio);

  Future<Response> getCaLamViecs() async {
    return await _dio.get('/bo-sung/ca-lam');
  }
}
