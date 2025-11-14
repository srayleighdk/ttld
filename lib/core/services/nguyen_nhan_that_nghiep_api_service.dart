import 'package:dio/dio.dart';

class NguyenNhanThatNghiepApiService {
  final Dio _dio;

  NguyenNhanThatNghiepApiService(this._dio);

  Future<Response> getNguyenNhanThatNghieps() async {
    return await _dio.get('/common/nguyen-nhan-tn');
  }
}
