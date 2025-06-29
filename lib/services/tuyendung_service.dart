import 'package:dio/dio.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';

class TuyenDungApiService {
  final Dio _dio;

  TuyenDungApiService(this._dio);

  Future<Response> getTuyenDungList(String? ntdId, {String? idUv}) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{};
      if (ntdId != null) {
        queryParams['idDoanhNghiep'] = ntdId;
      }
      if (idUv != null) {
        queryParams['idUv'] = idUv;
      }

      final response = await _dio.get(
        '/nghiep-vu/tuyendung',
        queryParameters: queryParams,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch tuyen dung: ${e.message}');
    }
  }

  Future<Response> createTuyenDung(NTDTuyenDung tuyenDung) async {
    return _dio.post('/nghiep-vu/tuyendung', data: tuyenDung.toJson());
  }

  Future<Response> updateTuyenDung(NTDTuyenDung tuyenDung) async {
    return _dio.put('/nghiep-vu/tuyendung', data: tuyenDung.toJson());
  }

  Future<Response> deleteTuyenDung(String idTuyenDung) async {
    return _dio.delete(
      '/nghiep-vu/tuyendung',
      queryParameters: {'id': idTuyenDung},
      options: Options(
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
