import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';

@injectable
class HinhThucTuyenDungApiService {
  final Dio _dio;

  HinhThucTuyenDungApiService(this._dio);

  Future<List<HinhThucTuyenDung>> getHinhThucTuyenDung() async {
    final response = await _dio.get('/bo-sung/hinh-thucTD');
    return (response.data['data'] as List)
        .map((json) => HinhThucTuyenDung.fromJson(json))
        .toList();
  }

  Future<void> createHinhThucTuyenDung(HinhThucTuyenDung hinhThuc) async {
    await _dio.post(
      '/bo-sung/hinh-thucTD',
      data: hinhThuc.toJson(),
    );
  }

  Future<void> updateHinhThucTuyenDung(HinhThucTuyenDung hinhThuc) async {
    await _dio.put(
      '/bo-sung/hinh-thucTD',
      data: hinhThuc.toJson(),
    );
  }

  Future<void> deleteHinhThucTuyenDung(String id) async {
    await _dio.delete(
      '/bo-sung/hinh-thucTD',
      data: {'id': id},
    );
  }
}
