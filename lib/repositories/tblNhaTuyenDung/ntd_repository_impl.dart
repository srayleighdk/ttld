import 'package:ttld/core/services/ntd_api_service.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';

class NTDRepositoryImpl implements NTDRepository {
  final NTDApiService _ntdApiService;

  NTDRepositoryImpl(this._ntdApiService);

  @override
  Future<List<NtdModel>> getNtdList() async {
    return await _ntdApiService.getNtdList();
  }

  @override
  Future<NtdModel> getNtdById(int id) async {
    return await _ntdApiService.getNtdById(id);
  }

  @override
  Future<NtdModel> addNtd(NtdModel ntd) async {
    return await _ntdApiService.addNtd(ntd);
  }

  @override
  Future<NtdModel> updateNtd(NtdModel ntd) async {
    return await _ntdApiService.updateNtd(ntd);
  }

  @override
  Future<void> deleteNtd(int id) async {
    return await _ntdApiService.deleteNtd(id);
  }
}
