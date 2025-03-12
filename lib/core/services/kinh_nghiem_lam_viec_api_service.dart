import 'package:injectable/injectable.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';

@injectable
class KinhNghiemLamViecApiService {
  final ApiClient _apiClient;

  KinhNghiemLamViecApiService(this._apiClient);

  Future<List<KinhNghiemLamViec>> getKinhNghiem() async {
    final response = await _apiClient.dio.get('/bo-sung/kinh-nghiem');
    return (response.data as List)
        .map((json) => KinhNghiemLamViec.fromJson(json))
        .toList();
  }

  Future<void> createKinhNghiem(KinhNghiemLamViec kinhNghiem) async {
    await _apiClient.dio.post(
      '/bo-sung/kinh-nghiem',
      data: kinhNghiem.toJson(),
    );
  }

  Future<void> updateKinhNghiem(KinhNghiemLamViec kinhNghiem) async {
    await _apiClient.dio.put(
      '/bo-sung/kinh-nghiem',
      data: kinhNghiem.toJson(),
    );
  }

  Future<void> deleteKinhNghiem(String id) async {
    await _apiClient.dio.delete(
      '/bo-sung/kinh-nghiem',
      data: {'id': id},
    );
  }
}
