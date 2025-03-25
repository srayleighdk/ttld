import 'package:dio/dio.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';

class TinhTrangHdApiService {
  final Dio _dio;

  TinhTrangHdApiService(this._dio);

  Future<List<TinhTrangHdModel>> getTinhTrangHd() async {
    final response = await _dio.get('/common/tinhtrang-hd');
    return (response.data['data'] as List)
        .map((json) => TinhTrangHdModel.fromJson(json))
        .toList();
  }
}
