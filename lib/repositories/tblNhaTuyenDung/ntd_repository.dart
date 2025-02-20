import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

abstract class NTDRepository {
  Future<List<Ntd>> getNtdList();
  Future<Ntd> getNtdById(int id);
  Future<Ntd> addNtd(Ntd ntd);
  Future<Ntd> updateNtd(Ntd ntd);
  Future<void> deleteNtd(int id);
}
