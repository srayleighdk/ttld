import 'package:freezed_annotation/freezed_annotation.dart';

part 'nhanvien_model.freezed.dart';
part 'nhanvien_model.g.dart';

@freezed
class NhanVien with _$NhanVien {
  const factory NhanVien({
    String? idphieu,
    DateTime? ngaylap,
    String? maphieu,
    String? idUv,
    String? idDn,
    String? hoten,
    DateTime? ngaysinh,
    int? idGioitinh,
    int? idDantoc,
    String? soCmnd,
    String? masoBhxh,
    String? idBacHoc,
    bool? chkCnktKhongBang,
    bool? chkCcn3thang,
    bool? chkCcnSocap,
    bool? chkTrungcap,
    bool? chkCaodang,
    bool? chkDaihocSdh,
    String? idLoaiDhld,
    DateTime? ngayHdld,
    DateTime? ngayHieuluc,
    int? idTinhtrangHd,
    int? idChucdanh,
    int? idLoaiBh,
    DateTime? ngayBaohiem,
    int? mucluongchinh,
    int? mucluongBhtn,
    int? thoigianBhtn,
    bool? chkNhanvienmoi,
    DateTime? ngayBatdau,
    DateTime? ngayThoiviec,
    int? idLydoNghi,
    String? ghichu,
    DateTime? startDate,
    DateTime? endDate,
    String? idphieu03,
    bool? status,
    int? displayOrder,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
    // Additional nested fields
    String? hoTenUv,
    String? loaiHDLD,
    String? ngaySinhUv,
    int? uvGioitinh,
    String? danTocUv,
    int? dantocId,
    String? soCmndUv,
    String? trinhdoCm,
    String? loaiBH,
    String? tenChucdanh,
    String? tinhtrangHd,
    String? tenDoanhnghiep,
  }) = _NhanVien;

  factory NhanVien.fromJson(Map<String, dynamic> json) =>
      _$NhanVienFromJson(json);
}
