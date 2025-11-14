import 'package:ttld/models/hoso_dtn/hoso_dtn_model.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

/// Helper class to map HoSoUngVien data to HosoDTN form
class HosoDTNMapper {
  /// Pre-populates HosoDTN form data from HoSoUngVien
  /// This ensures data consistency between the two entities
  static HosoDTN fromHoSoUngVien(TblHoSoUngVienModel hosoUV) {
    return HosoDTN(
      // User ID
      idtv: hosoUV.id,

      // Basic Information
      dkdtnHoten: hosoUV.uvHoten,
      dkdtnEmail: hosoUV.uvEmail,
      dkdtnDienthoai: hosoUV.uvDienthoai,
      dkdtnNgaysinh: hosoUV.uvNgaysinh != null
          ? DateTime.tryParse(hosoUV.uvNgaysinh!)
          : null,
      dkdtnGioitinh: hosoUV.uvGioitinh,

      // Physical Information
      chieuCao: hosoUV.uvChieucao,
      canNang: hosoUV.uvCannang,

      // Ethnicity & Religion
      dkdtnDantoc: hosoUV.idDanToc,
      // Note: TonGiao not available in HoSoUngVien

      // Current Profession/Specialization
      dkdtnChuyenmon: hosoUV.uvcmCongviechientai,

      // Address Information
      soNhaDuong: hosoUV.soNhaDuong,
      maTinh: hosoUV.idTinh,
      maHuyen: hosoUV.idhuyen,
      maXa: hosoUV.idxa,
      dkdtnHokhauthuongtru: hosoUV.uvDiachichitiet,

      // Family Information
      // Note: Family info (hoTenCha, hoTenMe, etc.) not available in HoSoUngVien
      
      // Marital Status
      docThan: hosoUV.uvHonnhanId == false, // Single if not married
      daCoGiaDinh: hosoUV.uvHonnhanId == true, // Has family if married

      // Contact Preferences
      dkdtnhtTelephone: hosoUV.uvhtTelephone,
      dkdtnhtEmail: hosoUV.uvhtEmail,
      dkdtnhtAddress: hosoUV.uvhtAddress,

      // Training/Education
      // Note: Training preferences (idDaoTao, dkdtndmNghedaotao, etc.) not in HoSoUngVien
      // These will need to be filled by user

      // Image
      imagePath: hosoUV.imagePath,

      // Set current date
      dkdtnNgay: DateTime.now(),
    );
  }

  /// Checks if essential HoSoUngVien data is available
  static bool hasEssentialData(TblHoSoUngVienModel? hosoUV) {
    if (hosoUV == null) return false;

    // Check for essential fields
    return hosoUV.uvHoten != null && hosoUV.uvHoten!.isNotEmpty;
  }

  /// Gets a summary of what data will be pre-filled
  static String getPrefilledSummary(TblHoSoUngVienModel hosoUV) {
    final fields = <String>[];
    
    if (hosoUV.uvHoten != null) fields.add('Họ tên');
    if (hosoUV.uvEmail != null) fields.add('Email');
    if (hosoUV.uvDienthoai != null) fields.add('Số điện thoại');
    if (hosoUV.uvNgaysinh != null) fields.add('Ngày sinh');
    if (hosoUV.uvGioitinh != null) fields.add('Giới tính');
    if (hosoUV.idDanToc != null) fields.add('Dân tộc');
    if (hosoUV.uvDiachichitiet != null) fields.add('Địa chỉ');
    if (hosoUV.uvChieucao != null) fields.add('Chiều cao');
    if (hosoUV.uvCannang != null) fields.add('Cân nặng');
    
    if (fields.isEmpty) {
      return 'Không có dữ liệu được điền sẵn';
    }
    
    return 'Đã điền sẵn: ${fields.join(', ')}';
  }
}

