import 'package:dio/dio.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';

class TuyenDungService {
  final Dio _dio;

  TuyenDungService(this._dio);

  Future<Response> getTuyenDungList() async {
    return _dio.get('/api/nghiep-vu/tuyendung');
  }

  Future<Response> createTuyenDung(NTDTuyenDung tuyenDung) async {
    return _dio.post('/api/nghiep-vu/tuyendung', data: tuyenDung.toJson());
  }

  Future<Response> updateTuyenDung(NTDTuyenDung tuyenDung) async {
    return _dio.put('/api/nghiep-vu/tuyendung', data: tuyenDung.toJson());
  }

  Future<Response> deleteTuyenDung(String idTuyenDung) async {
    return _dio.delete('/api/nghiep-vu/tuyendung', 
      data: {'idTuyenDung': idTuyenDung}
    );
  }
}
