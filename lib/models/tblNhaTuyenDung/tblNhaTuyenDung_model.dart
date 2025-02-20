import 'package:freezed_annotation/freezed_annotation.dart';

part 'tblNhaTuyenDung_model.freezed.dart';
part 'tblNhaTuyenDung_model.g.dart';

@freezed
class NtdModel with _$NtdModel {
  const factory NtdModel({
    required int idDoanhNghiep,
    String? username,
    String? password,
    required String ntdMadn,
    String? ntdTentat,
    String? ntdTen,
    String? imagePath,
    String? mst,
    int? ntdHinhThucDoanhNghiep,
    int? ntdSoLaoDong,
    String? ntdGioiThieu,
    int? ntdKdnId,
    String? ntdThuocKhuCongNghiep,
    int? ntdDiaChiThanhPho,
    String? ntdDiaChiHuyen,
    String? ntdDiaChiXaPhuong,
    String? ntdDiaChiChiTiet,
    String? ntdNguoiLienHe,
    String? ntdChucVu,
    String? ntdDienThoai,
    String? ntdFax,
    String? ntdEmail,
    String? ntdWebsite,
    @Default(false) bool ntdDuyet,
    @Default(false) bool ntdTopBlock,
    String? ntdQuocGia,
    int? ntdNamThanhLap,
    String? ntdLinhVucHoatDong,
    @Default(false) bool ntdhtNlh,
    @Default(false) bool ntdhtTelephone,
    @Default(false) bool ntdhtWeb,
    @Default(false) bool ntdhtFax,
    @Default(false) bool ntdhtEmail,
    @Default(false) bool ntdhtAddress,
    @Default('system') String createdBy,
    @Default('system') String modifiredBy,
    required DateTime createdDate,
    required DateTime modifiredDate,
    String? ntdId,
    @Default(false) bool newsletterSubscription,
    @Default(false) bool jobsletterSubscription,
    int? ntdLoai,
    String? nongThonThanhThi,
    String? idLoaiHinhDoanhNghiep,
    String? idNganhKinhTe,
    int? idThoiGianHoatDong,
    required int idStatus,
    required int displayOrder,
  }) = _NtdModel;

  factory NtdModel.fromJson(Map<String, dynamic> json) =>
      _$NtdModelFromJson(json);
}
