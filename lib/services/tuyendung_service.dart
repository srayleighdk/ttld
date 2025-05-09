import 'package:dio/dio.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';

class TuyenDungApiService {
  final Dio _dio;

  TuyenDungApiService(this._dio);

  Future<Response> getTuyenDungList(String? ntdId) async {
    return _dio
        .get('/nghiep-vu/tuyendung', queryParameters: {'idDoanhNghiep': ntdId});
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
