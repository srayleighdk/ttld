import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';

@injectable
class MucDichLamViecApiService {
  final Dio _dio;

  MucDichLamViecApiService(this._dio);

  Future<List<MucDichLamViec>> getMucDichLamViec() async {
    final response = await _dio.get('/bo-sung/muc-dich');
    return (response.data['data'] as List)
        .map((json) => MucDichLamViec.fromJson(json))
        .toList();
  }

  Future<void> createMucDichLamViec(MucDichLamViec mucDich) async {
    await _dio.post(
      '/bo-sung/muc-dich',
      data: mucDich.toJson(),
    );
  }

  Future<void> updateMucDichLamViec(MucDichLamViec mucDich) async {
    await _dio.put(
      '/bo-sung/muc-dich',
      data: mucDich.toJson(),
    );
  }

  Future<void> deleteMucDichLamViec(String id) async {
    await _dio.delete(
      '/bo-sung/muc-dich',
      data: {'id': id},
    );
  }
}
