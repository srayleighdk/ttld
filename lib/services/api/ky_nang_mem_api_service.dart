import 'package:dio/dio.dart';
import 'package:ttld/models/ky_nang_mem_model.dart';

class KyNangMemApiService {
  final Dio _dio;

  KyNangMemApiService(this._dio);

  Future<Response> getKyNangMem() async {
    return await _dio.get('/bo-sung/ky-nang');
  }

  Future<Response> postKyNangMem(KyNangMemModel data) async {
    return await _dio.post('/bo-sung/ky-nang', data: data);
  }

  Future<Response> putKyNangMem(KyNangMemModel data) async {
    return await _dio.put('/bo-sung/ky-nang', data: data);
  }

  Future<void> deleteKyNangMem(String id) async {
    await _dio.delete('bo-sung/ky-nang', queryParameters: {
      'id': id,
    });
  }
}
