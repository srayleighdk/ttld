import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/core/utils/int_to_bool_converter.dart';

part 'm02tt11_model.freezed.dart';
part 'm02tt11_model.g.dart';

@freezed
class M02TT11 with _$M02TT11 {
  const factory M02TT11({
    // Basic Information
    String? idphieu,
    String? maphieu,
    DateTime? ngaylap,
    String? iduv,
    String? hoten,
    DateTime? ngaysinh,
    int? idGioitinh,
    String? soCmnd,
    DateTime? ngaycap,
    String? noicap,
    String? masoBhxh,
    int? idDantoc,
    int? idTongiao,
    int? idStatusVieclam,
    int? idDoituongCs,
    int? idTantat,
    @IntToBoolConverter() bool? idTtHonNhan,
    String? mahoGd,

    // Residential address (Hộ khẩu) - Old codes
    String? matinhHk,
    String? mahuyenHk,
    String? maxaHk,
    String? diachiHk,
    String? thonHk,

    // Residential address (Hộ khẩu) - New IDs
    int? idTinhHk,
    int? idXaHk,

    // Temporary address (Tạm trú) - Old codes
    String? matinhTt,
    String? mahuyenTt,
    String? maxaTt,
    String? diachiTt,
    String? thonTt,

    // Temporary address (Tạm trú) - New IDs
    int? idTinhTt,
    int? idXaTt,

    // Health Information
    String? suckhoe,
    int? cao,
    double? nang,

    // Current Employment
    String? congviechientai,
    int? idNguyennhanTn,
    double? mucLuongTruocThatNghiep,

    // Education & Training (Trình độ đào tạo)
    int? idhocvan,
    String? idBacHoc,
    int? idChuyenmon,
    String? idBacHocKhac,
    int? idChuyenmonKhac,
    String? trinhdok1,
    String? trinhdok2,
    String? kynangnghe,
    int? backynang,

    // Foreign language (Ngoại ngữ)
    int? idNndt1,
    String? idTdnn1,
    int? mucNn1,
    int? idNndt2,
    String? idTdnn2,
    int? mucNn2,

    // Computer skills (Tin học)
    String? idTdth,
    int? mucTh,
    String? idTdthvp,
    int? mucThvp,

    // Soft skills (Kỹ năng mềm)
    String? idKynang,
    @IntToBoolConverter() bool? chkGt,
    @IntToBoolConverter() bool? chkNs,
    @IntToBoolConverter() bool? chkNhom,
    @IntToBoolConverter() bool? chkGs,
    @IntToBoolConverter() bool? chkKhac,
    @IntToBoolConverter() bool? chkTtr,
    @IntToBoolConverter() bool? chkTh,
    @IntToBoolConverter() bool? chkDl,
    @IntToBoolConverter() bool? chkPb,
    @IntToBoolConverter() bool? chkQltg,
    @IntToBoolConverter() bool? chkTu,
    @IntToBoolConverter() bool? chkApl,
    String? kynangkhac,
    String? khanangNoitroi,

    // Work experience (Kinh nghiệm làm việc)
    String? kinhnghiemLv,
    @IntToBoolConverter() bool? lvNuocngoai,
    String? lvNuocngoaitai,
    String? idLhdn,

    // Job requirements (Điều kiện việc làm)
    String? tenVv,
    String? motaCv,
    int? nganhId,
    int? level1,
    int? level2,
    int? level3,
    int? level4,
    int? idChucvu,
    String? idKinhnghiem,

    // Work location (Nơi làm việc)
    String? noiLvTinh1,
    int? noiLvkcn1,
    String? noiLvTinh2,
    int? noiLvkcn2,

    // Work conditions (Điều kiện làm việc)
    String? idLoaiDhld,
    int? idCalamviec,
    String? idHinhthuc,
    String? idMucdich,
    int? idMucluong,
    String? dieukienlamviec,

    // Benefits (Phúc lợi)
    @IntToBoolConverter() bool? chkPl01,
    @IntToBoolConverter() bool? chkPl02,
    @IntToBoolConverter() bool? chkPl03,
    @IntToBoolConverter() bool? chkPl04,
    int? tienPhucloi,
    @IntToBoolConverter() bool? chkPl05,
    @IntToBoolConverter() bool? chkPl06,
    @IntToBoolConverter() bool? chkPl07,
    @IntToBoolConverter() bool? chkPl08,
    @IntToBoolConverter() bool? chkPl09,
    @IntToBoolConverter() bool? chkPl10,
    @IntToBoolConverter() bool? chkPl11,
    @IntToBoolConverter() bool? chkPl12,
    @IntToBoolConverter() bool? chkPl13,
    @IntToBoolConverter() bool? chkPl14,
    @IntToBoolConverter() bool? chkPl15,
    @IntToBoolConverter() bool? chkPl16,
    @IntToBoolConverter() bool? chkPl17,
    String? phucloikhac,

    // Work preferences (Yêu cầu khác)
    @IntToBoolConverter() bool? chkNl1,
    @IntToBoolConverter() bool? chkNl2,
    @IntToBoolConverter() bool? chkNl3,
    @IntToBoolConverter() bool? chkTl1,
    @IntToBoolConverter() bool? chkTl2,
    @IntToBoolConverter() bool? chkTl3,
    @IntToBoolConverter() bool? chkDl1,
    @IntToBoolConverter() bool? chkDl2,
    @IntToBoolConverter() bool? chkDl3,
    @IntToBoolConverter() bool? chkNn1,
    @IntToBoolConverter() bool? chkNn2,
    @IntToBoolConverter() bool? chkNn3,
    @IntToBoolConverter() bool? chkY01,
    @IntToBoolConverter() bool? chkY02,
    @IntToBoolConverter() bool? chkTy1,
    @IntToBoolConverter() bool? chkTy2,
    @IntToBoolConverter() bool? chkTy3,
    @IntToBoolConverter() bool? chk2T1,
    @IntToBoolConverter() bool? chk2T2,
    @IntToBoolConverter() bool? chk2T3,
    @IntToBoolConverter() bool? chk2T4,
    @IntToBoolConverter() bool? chk2T5,
    @IntToBoolConverter() bool? sslv1,
    @IntToBoolConverter() bool? sslv2,

    // Consultation (Đăng ký tư vấn)
    @IntToBoolConverter() bool? chkTuvanCs,
    @IntToBoolConverter() bool? chkTuvanVl,
    @IntToBoolConverter() bool? chkTuvanDt,
    @IntToBoolConverter() bool? chkTuvanBhtn,
    @IntToBoolConverter() bool? chkTuvankhac,
    String? dKyKhac,

    // Contact information (Thông tin liên hệ)
    String? idHinhthucTd,
    String? tenLienhe,
    String? dienthoai,
    String? email,
    @IntToBoolConverter() bool? nhanSms,
    @IntToBoolConverter() bool? nhanEMail,
    String? hinhthuckhac,
    String? lienHeTimViec,

    // File & Data Source
    String? urlFile,
    String? idNguonThuThap,
    String? idVetinh,

    // System fields
    String? tenNguoiViet,
    int? displayOrder,
    @IntToBoolConverter() bool? status,
  }) = _M02TT11;

  factory M02TT11.fromJson(Map<String, dynamic> json) =>
      _$M02TT11FromJson(json);
}
