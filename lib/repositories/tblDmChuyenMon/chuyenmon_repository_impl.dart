import 'package:ttld/core/services/chuyenmon_api_service.dart';
import 'package:ttld/models/chuyenmon/chuyenmon.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository.dart';

class ChuyenMonRepositoryImpl implements ChuyenMonRepository {
  final ChuyenMonApiService chuyenMonApiService;

  ChuyenMonRepositoryImpl(this.chuyenMonApiService); // Inject the API service

  @override
  Future<List<ChuyenMon>> getChuyenMons() async {
    return await chuyenMonApiService.getChuyenMons();
  }

  @override
  Future<ChuyenMon> createChuyenMon(ChuyenMon chuyenMon) async {
    return await chuyenMonApiService.createChuyenMon(chuyenMon);
  }

  @override
  Future<ChuyenMon> updateChuyenMon(int id, ChuyenMon chuyenMon) async {
    return await chuyenMonApiService.updateChuyenMon(id, chuyenMon);
  }

  @override
  Future<void> deleteChuyenMon(int id) async {
    await chuyenMonApiService.deleteChuyenMon(id);
  }
}
