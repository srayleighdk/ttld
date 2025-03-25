import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';

@injectable
class LoaiHopDongLaoDongApiService {
  final Dio _dio;

  LoaiHopDongLaoDongApiService(this._dio);

  Future<List<LoaiHopDongLaoDong>> getLoaiHopDong() async {
    final response = await _dio.get('/bo-sung/loai-hd');
    return (response.data['data'] as List)
        .map((json) => LoaiHopDongLaoDong.fromJson(json))
        .toList();
  }

  Future<void> createLoaiHopDong(LoaiHopDongLaoDong loaiHopDong) async {
    await _dio.post(
      '/bo-sung/loai-hd',
      data: loaiHopDong.toJson(),
    );
  }

  Future<void> updateLoaiHopDong(LoaiHopDongLaoDong loaiHopDong) async {
    await _dio.put(
      '/bo-sung/loai-hd',
      data: loaiHopDong.toJson(),
    );
  }

  Future<void> deleteLoaiHopDong(String id) async {
    await _dio.delete(
      '/bo-sung/loai-hd',
      data: {'id': id},
    );
  }
}
