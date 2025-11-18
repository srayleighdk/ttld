import 'package:ttld/core/services/bhtn_khoadaotao_api_service.dart';
import 'package:ttld/models/bhtn_khoadaotao/bhtn_khoadaotao_model.dart';

abstract class BhtnKhoadaotaoRepository {
  Future<List<BhtnKhoadaotao>> getBhtnKhoadaotaos();
  Future<BhtnKhoadaotao> getBhtnKhoadaotaoById(int id);
  Future<BhtnKhoadaotao> createBhtnKhoadaotao(BhtnKhoadaotao khoadaotao);
  Future<BhtnKhoadaotao> updateBhtnKhoadaotao(
      int id, BhtnKhoadaotao khoadaotao);
  Future<void> deleteBhtnKhoadaotao(int id);
}

class BhtnKhoadaotaoRepositoryImpl implements BhtnKhoadaotaoRepository {
  BhtnKhoadaotaoRepositoryImpl({required this.bhtnKhoadaotaoApiService});
  final BhtnKhoadaotaoApiService bhtnKhoadaotaoApiService;

  @override
  Future<List<BhtnKhoadaotao>> getBhtnKhoadaotaos() async {
    return await bhtnKhoadaotaoApiService.getBhtnKhoadaotaos();
  }

  @override
  Future<BhtnKhoadaotao> getBhtnKhoadaotaoById(int id) async {
    return await bhtnKhoadaotaoApiService.getBhtnKhoadaotaoById(id);
  }

  @override
  Future<BhtnKhoadaotao> createBhtnKhoadaotao(BhtnKhoadaotao khoadaotao) async {
    return await bhtnKhoadaotaoApiService.createBhtnKhoadaotao(khoadaotao);
  }

  @override
  Future<BhtnKhoadaotao> updateBhtnKhoadaotao(
      int id, BhtnKhoadaotao khoadaotao) async {
    return await bhtnKhoadaotaoApiService.updateBhtnKhoadaotao(id, khoadaotao);
  }

  @override
  Future<void> deleteBhtnKhoadaotao(int id) async {
    return await bhtnKhoadaotaoApiService.deleteBhtnKhoadaotao(id);
  }
}
