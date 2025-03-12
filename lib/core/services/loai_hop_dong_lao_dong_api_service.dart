import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';

@injectable
class LoaiHopDongLaoDongApiService {
  final ApiClient _apiClient;

  LoaiHopDongLaoDongApiService(this._apiClient);

  Future<List<LoaiHopDongLaoDong>> getLoaiHopDong() async {
    final response = await _apiClient.dio.get('/bo-sung/loai-hd');
    return (response.data as List)
        .map((json) => LoaiHopDongLaoDong.fromJson(json))
        .toList();
  }

  Future<void> createLoaiHopDong(LoaiHopDongLaoDong loaiHopDong) async {
    await _apiClient.dio.post(
      '/bo-sung/loai-hd',
      data: loaiHopDong.toJson(),
    );
  }

  Future<void> updateLoaiHopDong(LoaiHopDongLaoDong loaiHopDong) async {
    await _apiClient.dio.put(
      '/bo-sung/loai-hd',
      data: loaiHopDong.toJson(),
    );
  }

  Future<void> deleteLoaiHopDong(String id) async {
    await _apiClient.dio.delete(
      '/bo-sung/loai-hd',
      data: {'id': id},
    );
  }
}
