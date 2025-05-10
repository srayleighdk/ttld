import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

abstract class NTDRepository {
  Future<List<Ntd>> getNtdList({
    int? limit,
    int? page,
    int? ntdLoai,
    int? idStatus,
    String? search,
    int? idUv,
  });
  Future<Ntd> getNtdById(int id);
  Future<Ntd> addNtd(Ntd ntd);
  Future<Ntd> updateNtd(Ntd ntd);
  Future<void> deleteNtd(int id);
}
