import 'package:ttld/core/services/hinh_thuc_dao_tao_api_service.dart';
import 'package:ttld/models/hinh_thuc_dao_tao_model.dart';

abstract class HinhThucDaoTaoRepository {
  Future<List<HinhThucDaoTao>> getHinhThucDaoTaos();
  Future<HinhThucDaoTao> addHinhThucDaoTao(HinhThucDaoTao hinhThucDaoTao);
  Future<HinhThucDaoTao> updateHinhThucDaoTao(HinhThucDaoTao hinhThucDaoTao);
  Future<void> deleteHinhThucDaoTao(String id);
}

class HinhThucDaoTaoRepositoryImpl implements HinhThucDaoTaoRepository {
  final HinhThucDaoTaoApiService hinhThucDaoTaoApiService;

  HinhThucDaoTaoRepositoryImpl({required this.hinhThucDaoTaoApiService});

  @override
  Future<List<HinhThucDaoTao>> getHinhThucDaoTaos() async {
    final response = await hinhThucDaoTaoApiService.getHinhThucDaoTao();
    return (response.data['data'] as List)
        .map((json) => HinhThucDaoTao.fromJson(json))
        .toList();
  }

  @override
  Future<HinhThucDaoTao> addHinhThucDaoTao(HinhThucDaoTao hinhThucDaoTao) async {
    final response = await hinhThucDaoTaoApiService.postHinhThucDaoTao(hinhThucDaoTao.toJson());
    return HinhThucDaoTao.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<HinhThucDaoTao> updateHinhThucDaoTao(HinhThucDaoTao hinhThucDaoTao) async {
    final response = await hinhThucDaoTaoApiService.putHinhThucDaoTao(hinhThucDaoTao.toJson());
    return HinhThucDaoTao.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteHinhThucDaoTao(String id) async {
    await hinhThucDaoTaoApiService.deleteHinhThucDaoTao(id);
  }
}
