import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

/// Helper class to map HoSoUngVien data to M02TT11 form
class M02TT11Mapper {
  /// Pre-populates M02TT11 form data from HoSoUngVien
  /// This ensures data consistency between the two entities
  static M02TT11 fromHoSoUngVien(TblHoSoUngVienModel hosoUV) {
    return M02TT11(
      // User ID
      iduv: hosoUV.id,

      // Basic Information
      hoten: hosoUV.uvHoten,
      soCmnd: hosoUV.uvSoCmnd,
      ngaysinh: hosoUV.uvNgaysinh != null
          ? DateTime.tryParse(hosoUV.uvNgaysinh!)
          : null,
      ngaycap: hosoUV.uvNgaycap != null
          ? DateTime.tryParse(hosoUV.uvNgaycap!)
          : null,
      noicap: hosoUV.uvNoicap,
      idGioitinh: hosoUV.uvGioitinh,
      mahoGd: hosoUV.mahoGd,

      // Physical Information
      cao: hosoUV.uvChieucao != null
          ? int.tryParse(hosoUV.uvChieucao!)
          : null,
      nang: hosoUV.uvCannang != null
          ? double.tryParse(hosoUV.uvCannang!)
          : null,

      // Current Employment
      congviechientai: hosoUV.uvcmCongviechientai,

      // Address - Old System (Permanent Address)
      matinhHk: hosoUV.idTinh,
      mahuyenHk: hosoUV.idhuyen,
      maxaHk: hosoUV.idxa,

      // Address - New System (Permanent Address)
      idTinhHk: hosoUV.idTinhMoi,
      idXaHk: hosoUV.idxaMoi,

      // Education
      idBacHoc: hosoUV.idBacHoc,
      idhocvan: hosoUV.uvcmTrinhdoId,

      // Contact Information
      dienthoai: hosoUV.uvDienthoai,
      email: hosoUV.uvEmail,

      // Data Source
      idNguonThuThap: hosoUV.idNguonThuThap,

      // Salary Level
      idMucluong: hosoUV.idMucluong,

      // Related IDs
      idDantoc: hosoUV.idDanToc,
      idTtHonNhan: hosoUV.uvHonnhanId,
      idTantat: hosoUV.uvTinhtrangtantatId,
      idDoituongCs: hosoUV.uvDoituongchinhsachId,
      nganhId: hosoUV.uvnvNganhngheId,

      // Set status to active by default
      status: true,
      ngaylap: DateTime.now(),
    );
  }

  /// Checks if essential HoSoUngVien data is available
  static bool hasEssentialData(TblHoSoUngVienModel? hosoUV) {
    if (hosoUV == null) return false;

    // Check for essential fields
    return hosoUV.uvHoten != null &&
           hosoUV.uvHoten!.isNotEmpty;
  }
}
