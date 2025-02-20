import 'package:dio/dio.dart';

class TrinhDoVanHoaApiService {
  final Dio _dio;

  TrinhDoVanHoaApiService(this._dio);

  Future<Response> getTrinhDoVanHoa() async {
    return await _dio.get('/api/danhmuc/trinh-do/van-hoa');
  }

  Future<Response> postTrinhDoVanHoa(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/trinh-do/van-hoa', data);
  }

  Future<Response> putTrinhDoVanHoa(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/trinh-do/van-hoa', data);
  }

  Future<void> deleteTrinhDoVanHoa(String id) async {
    await _dio.delete('/api/danhmuc/trinh-do/van-hoa/$id');
  }
}
