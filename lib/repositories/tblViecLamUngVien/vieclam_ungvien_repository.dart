import 'package:ttld/models/tblViecLamUngVien/vieclam_ungvien_model.dart';

abstract class ViecLamUngVienRepository {
  Future<List<TblViecLamUngVienModel>> getViecLamUngVienList();
}
