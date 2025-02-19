import 'package:ttld/core/services/tttantat_api_service.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/repositories/tblDmTTtantat/tantat_repository.dart';

class TinhTrangTanTatRepositoryImpl implements TinhTrangTanTatRepository {
  final TinhTrangTanTatApiService tinhTrangTanTatApiService;

  TinhTrangTanTatRepositoryImpl(
      this.tinhTrangTanTatApiService); // Inject the API service

  @override
  Future<List<TinhTrangTanTat>> getTinhTrangTanTats() async {
    return await tinhTrangTanTatApiService.getTinhTrangTanTats();
  }

  @override
  Future<TinhTrangTanTat> createTinhTrangTanTat(
      TinhTrangTanTat tinhTrangTanTat) async {
    return await tinhTrangTanTatApiService
        .createTinhTrangTanTat(tinhTrangTanTat);
  }

  @override
  Future<TinhTrangTanTat> updateTinhTrangTanTat(
      int id, TinhTrangTanTat tinhTrangTanTat) async {
    return await tinhTrangTanTatApiService.updateTinhTrangTanTat(
        id, tinhTrangTanTat);
  }

  @override
  Future<void> deleteTinhTrangTanTat(int id) async {
    await tinhTrangTanTatApiService.deleteTinhTrangTanTat(id);
  }
}
