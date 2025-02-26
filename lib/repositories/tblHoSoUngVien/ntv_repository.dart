import 'package:ttld/core/services/ntv_api_service.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

class NtvRepository {
  final NTVApiService _ntvApiService;

  NtvRepository(this._ntvApiService);

  Future<List<TblHoSoUngVienModel>> getAllHoSoUngVien() async {
    return await _ntvApiService.getHoSoUngVienList();
  }

  Future<TblHoSoUngVienModel?> getHoSoUngVienById(String id) async {
    return await _ntvApiService.getHoSoUngVienById(id);
  }

  Future<TblHoSoUngVienModel> createHoSoUngVien(
      TblHoSoUngVienModel tblHoSoUngVien) async {
    return await _ntvApiService.addHoSoUngVien(tblHoSoUngVien);
  }

  Future<TblHoSoUngVienModel> updateHoSoUngVien(
      String id, TblHoSoUngVienModel tblHoSoUngVien) async {
    return await _ntvApiService.updateHoSoUngVien(tblHoSoUngVien);
  }

  Future<void> deleteHoSoUngVien(String id) async {
    // Assuming the API takes an integer ID for deletion
    int? idInt = int.tryParse(id);
    if (idInt != null) {
      return await _ntvApiService.deleteHoSoUngVien(idInt);
    } else {
      throw ArgumentError("Invalid ID format.  ID must be an integer.");
    }
  }
}
