import 'package:ttld/core/services/vieclam_ungvien_api_service.dart';
import 'package:ttld/models/tblViecLamUngVien/vieclam_ungvien_model.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';

class ViecLamUngVienRepositoryImpl implements ViecLamUngVienRepository {
  final ViecLamUngVienApiService viecLamUngVienApiService;

  ViecLamUngVienRepositoryImpl({required this.viecLamUngVienApiService});

  @override
  Future<List<TblViecLamUngVienModel>> getViecLamUngVienList() async {
    return await viecLamUngVienApiService.getViecLamUngVienList();
  }
}
