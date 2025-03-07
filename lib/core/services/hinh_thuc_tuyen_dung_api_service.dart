import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';

@injectable
class HinhThucTuyenDungApiService {
  final ApiClient _apiClient;

  HinhThucTuyenDungApiService(this._apiClient);

  Future<List<HinhThucTuyenDung>> getHinhThucTuyenDung() async {
    final response = await _apiClient.dio.get('/api/bo-sung/hinh-thucTD');
    return (response.data as List)
        .map((json) => HinhThucTuyenDung.fromJson(json))
        .toList();
  }

  Future<void> createHinhThucTuyenDung(HinhThucTuyenDung hinhThuc) async {
    await _apiClient.dio.post(
      '/api/bo-sung/hinh-thucTD',
      data: hinhThuc.toJson(),
    );
  }

  Future<void> updateHinhThucTuyenDung(HinhThucTuyenDung hinhThuc) async {
    await _apiClient.dio.put(
      '/api/bo-sung/hinh-thucTD',
      data: hinhThuc.toJson(),
    );
  }

  Future<void> deleteHinhThucTuyenDung(String id) async {
    await _apiClient.dio.delete(
      '/api/bo-sung/hinh-thucTD',
      data: {'id': id},
    );
  }
}
