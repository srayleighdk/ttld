import 'package:ttld/core/services/ntd_api_service.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';

class NTDRepositoryImpl implements NTDRepository {
  final NTDApiService _ntdApiService;

  NTDRepositoryImpl(this._ntdApiService);

  @override
  Future<List<Ntd>> getNtdList({
    int? limit,
    int? page,
    int? ntdLoai,
    int? idStatus,
    String? search,
    int? idUv,
  }) async {
    return await _ntdApiService.getNtdList(
      limit: limit,
      page: page,
      ntdLoai: ntdLoai,
      idStatus: idStatus,
      search: search,
      idUv: idUv,
    );
  }

  @override
  Future<Ntd> getNtdById(int id) async {
    try {
      return await _ntdApiService.getNtdById(id.toString());
    } catch (e) {
      print('Error fetching NTD by ID: $e');
      rethrow;
    }
  }

  @override
  Future<Ntd> addNtd(Ntd ntd) async {
    return await _ntdApiService.addNtd(ntd);
  }

  @override
  Future<Ntd> updateNtd(Ntd ntd) async {
    return await _ntdApiService.updateNtd(ntd);
  }

  @override
  Future<void> deleteNtd(int id) async {
    return await _ntdApiService.deleteNtd(id);
  }
}
