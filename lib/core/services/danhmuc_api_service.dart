import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class DanhMucApiService {
  final Dio _dio;

  DanhMucApiService(this._dio);

  Future<Response> getKCN(String matinh) async {
    return await _dio.get('/api/danhmuc/KCN', queryParameters: {'matinh': matinh});
  }
}
