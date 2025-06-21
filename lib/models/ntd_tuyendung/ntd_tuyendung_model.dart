import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntd_tuyendung_model.freezed.dart';
part 'ntd_tuyendung_model.g.dart';

@freezed
class NTDTuyenDung with _$NTDTuyenDung {
  const factory NTDTuyenDung({
    String? idTuyenDung,
    String? tdTieude,
    int? tdChucDanh,
    String? tdNganhkhac,
    int? tdSoluong,
    String? tdMotacongviec,
    String? tdMotayeucau,
    String? tdQuyenloi,
    String? tdGhichu,
    int? tdLuongkhoidiem,
    String? ngayNhanHoSo,
    String? ngayHetNhanHoSo,
    bool? isDenKhiTuyenXong,
    String? tdNoinophoso,
    String? tdHosobaogom,
    int? tdYeuCauChieuCao,
    int? tdYeucauKinhnghiem,
    int? tdYeucauTuoiMin,
    int? tdYeucauTuoiMax,
    int? tdLanxem,
    bool? tdDuyet,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
    String? tdId,
    String? tdIdDoanhnghiep,
    String? nguonThuThap,
    int? soLuongDat,
    int? soLuongKhongDat,
    int? soLuongChoKetQua,
    int? idMucLuong,
    int? idDoTuoi,
    String? doanhNghiepYeuCau,
    int? idDoituongCs,
    String? idphieut11,
    String? idDoanhNghiep,
    int? tdNoilamviec,
    int? tdNganhnghe,
    int? tdYeuCauHocVan,
    int? tdThoigianlamviec,
    String? idKinhnghiem,
    String? idBacHoc,
    String? idKynang,
    String? idHinhthucLv,
    String? tdYeuCauTinHoc,
    String? tdYeuCauNgoaiNgu,
    int? tdYeuCauGioiTinh,
    String? maHoso,
    String? nguoiLienhe,
    String? soDienthoai,
    String? diaChiDn,
    String? tenDoanhNghiep,
    String? noiLamviec,
    String? tenNganhnghe,
    String? mucLuong,
  }) = _NTDTuyenDung;

  factory NTDTuyenDung.fromJson(Map<String, dynamic> json) =>
      _$NTDTuyenDungFromJson(
        // Sanitize tdMotacongviec before passing to generated deserializer
        <String, dynamic>{
          ...json,
          'tdMotacongviec': _sanitizeString(json['tdMotacongviec']?.toString()),
        },
      );

  static String? _sanitizeString(String? input) {
    if (input == null) return null;
    // Replace non-ASCII characters or invalid sequences
    return input.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    // Alternatively, keep valid UTF-8 characters but replace malformed ones
    // return utf8.decode(input.runes.toList(), allowMalformed: true);
  }
}
