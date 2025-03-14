import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntd_tuyendung_model.freezed.dart';
part 'ntd_tuyendung_model.g.dart';

@freezed
class NTDTuyenDung with _$NTDTuyenDung {
  const factory NTDTuyenDung({
    String? idTuyenDung,
    required String tdTieude,
    required int tdChucDanh,
    String? tdNganhkhac,
    required int tdSoluong,
    String? tdMotacongviec,
    String? tdMotayeucau,
    String? tdQuyenloi,
    String? tdGhichu,
    required int tdLuongkhoidiem,
    required DateTime ngayNhanHoSo,
    required DateTime ngayHetNhanHoSo,
    required bool isDenKhiTuyenXong,
    String? tdNoinophoso,
    String? tdHosobaogom,
    required int tdYeuCauChieuCao,
    required int tdYeucauKinhnghiem,
    required int tdYeucauTuoiMin,
    required int tdYeucauTuoiMax,
    required int tdLanxem,
    required bool tdDuyet,
    required DateTime createdDate,
    required String createdBy,
    required DateTime modifiredDate,
    required String modifiredBy,
    String? tdId,
    required String tdIdDoanhnghiep,
    required String nguonThuThap,
    required int soLuongDat,
    required int soLuongKhongDat,
    required int soLuongChoKetQua,
    required int idMucLuong,
    required int idDoTuoi,
    String? doanhNghiepYeuCau,
    required int idDoituongCs,
    String? idphieut11,
    required String idDoanhNghiep,
    required int tdNoilamviec,
    required int tdNganhnghe,
    required int tdYeuCauHocVan,
    required int tdThoigianlamviec,
    required String idKinhnghiem,
    required String idBacHoc,
    required String idKynang,
    required String idHinhthucLv,
    required String tdYeuCauTinHoc,
    required String tdYeuCauNgoaiNgu,
    required int tdYeuCauGioiTinh,
    required String maHoso,
    required String nguoiLienhe,
    required String soDienthoai,
    required String diaChiDn,
    required String tenDoanhNghiep,
    required String noiLamviec,
    required String tenNganhnghe,
    required String mucLuong,
  }) = _NTDTuyenDung;

  factory NTDTuyenDung.fromJson(Map<String, dynamic> json) =>
      _$NTDTuyenDungFromJson(json);
}
