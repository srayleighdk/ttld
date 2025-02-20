import 'package:ttld/core/services/thoigianlamviec_api_service.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';

abstract class ThoiGianLamViecRepository {
  Future<List<ThoiGianLamViec>> getThoiGianLamViecs();
  Future<ThoiGianLamViec> addThoiGianLamViec(ThoiGianLamViec thoiGianLamViec);
  Future<ThoiGianLamViec> updateThoiGianLamViec(ThoiGianLamViec thoiGianLamViec);
  Future<void> deleteThoiGianLamViec(String id);
}

class ThoiGianLamViecRepositoryImpl implements ThoiGianLamViecRepository {
  final ThoiGianLamViecApiService thoiGianLamViecApiService;

  ThoiGianLamViecRepositoryImpl({required this.thoiGianLamViecApiService});

  @override
  Future<List<ThoiGianLamViec>> getThoiGianLamViecs() async {
    final response = await thoiGianLamViecApiService.getThoiGianLamViec();
    return (response.data['data'] as List)
        .map((json) => ThoiGianLamViec.fromJson(json))
        .toList();
  }

  @override
  Future<ThoiGianLamViec> addThoiGianLamViec(ThoiGianLamViec thoiGianLamViec) async {
    final response = await thoiGianLamViecApiService.postThoiGianLamViec(thoiGianLamViec.toJson());
    return ThoiGianLamViec.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<ThoiGianLamViec> updateThoiGianLamViec(ThoiGianLamViec thoiGianLamViec) async {
    final response = await thoiGianLamViecApiService.putThoiGianLamViec(thoiGianLamViec.toJson());
    return ThoiGianLamViec.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteThoiGianLamViec(String id) async {
    await thoiGianLamViecApiService.deleteThoiGianLamViec(id);
  }
}
