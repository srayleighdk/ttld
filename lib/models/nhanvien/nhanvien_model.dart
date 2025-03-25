import 'package:freezed_annotation/freezed_annotation.dart';

part 'nhanvien_model.freezed.dart';
part 'nhanvien_model.g.dart';

@freezed
class NhanVien with _$NhanVien {
  const factory NhanVien({
    String? idphieu,
    String? ngaylap,
    String? maphieu,
    String? idUv,
    int? idDn,
    String? hoten,
    String? ngaysinh,
    int? idGioitinh,
    int? idDantoc,
    String? soCmnd,
    String? masoBhxh,
    int? idBacHoc,
    bool? chkCnktKhongBang,
    bool? chkCcn3thang,
    bool? chkCcnSocap,
    bool? chkTrungcap,
    bool? chkCaodang,
    bool? chkDaihocSdh,
    String? idLoaiDhld,
    String? ngayHdld,
    String? ngayHieuluc,
    int? idTinhtrangHd,
    int? idChucdanh,
    int? idLoaiBh,
    String? ngayBaohiem,
    int? mucluongchinh,
    int? mucluongBhtn,
    int? thoigianBhtn,
    bool? chkNhanvienmoi,
    String? ngayBatdau,
    String? ngayThoiviec,
    int? idLydoNghi,
    String? ghichu,
    DateTime? startDate,
    DateTime? endDate,
    String? idphieu03,
    bool? status,
    int? displayOrder,
    String? createdDate,
    String? createdBy,
    String? modifiredDate,
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
