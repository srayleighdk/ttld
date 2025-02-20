import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

abstract class NTDRepository {
  Future<List<NtdModel>> getNtdList();
  Future<NtdModel> getNtdById(int id);
  Future<NtdModel> addNtd(NtdModel ntd);
  Future<NtdModel> updateNtd(NtdModel ntd);
  Future<void> deleteNtd(int id);
}
