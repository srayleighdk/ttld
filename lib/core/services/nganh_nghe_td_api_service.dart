import 'package:dio/dio.dart';

class NganhNgheTDApiService {
  final Dio _dio;

  NganhNgheTDApiService(this._dio);

  Future<Response> getNganhNgheTD() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/tuyen-dung');
  }
}
