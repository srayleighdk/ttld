import 'package:dio/dio.dart';

class TrinhDoVanHoaApiService {
  final Dio _dio;

  TrinhDoVanHoaApiService(this._dio);

  Future<Response> getTrinhDoVanHoa() async {
    return await _dio.get('/danhmuc/trinh-do/van-hoa');
  }

  Future<Response> postTrinhDoVanHoa(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/trinh-do/van-hoa', data: data);
  }

  Future<Response> putTrinhDoVanHoa(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/trinh-do/van-hoa', data: data);
  }

  Future<void> deleteTrinhDoVanHoa(String id) async {
    await _dio.delete('/danhmuc/trinh-do/van-hoa', queryParameters: {
      'id': id,
    });
  }
}
