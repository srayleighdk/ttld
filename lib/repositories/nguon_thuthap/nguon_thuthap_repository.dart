import 'package:ttld/core/services/nguon_thuthap_api_service.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';

abstract class NguonThuThapRepository {
  Future<List<NguonThuThap>> getNguonThuThaps();
  Future<NguonThuThap> addNguonThuThap(NguonThuThap nguonThuThap);
  Future<NguonThuThap> updateNguonThuThap(NguonThuThap nguonThuThap);
  Future<void> deleteNguonThuThap(String id);
}

class NguonThuThapRepositoryImpl implements NguonThuThapRepository {
  final NguonThuThapApiService nguonThuThapApiService;

  NguonThuThapRepositoryImpl(this.nguonThuThapApiService);

  @override
  Future<List<NguonThuThap>> getNguonThuThaps() async {
    final response = await nguonThuThapApiService.getNguonThuThap();
    return (response.data['data'] as List)
        .map((json) => NguonThuThap.fromJson(json))
        .toList();
  }

  @override
  Future<NguonThuThap> addNguonThuThap(NguonThuThap nguonThuThap) async {
    final response =
        await nguonThuThapApiService.postNguonThuThap(nguonThuThap.toJson());
    return NguonThuThap.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NguonThuThap> updateNguonThuThap(NguonThuThap nguonThuThap) async {
    final response =
        await nguonThuThapApiService.putNguonThuThap(nguonThuThap.toJson());
    return NguonThuThap.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNguonThuThap(String id) async {
    await nguonThuThapApiService.deleteNguonThuThap(id);
  }
}
