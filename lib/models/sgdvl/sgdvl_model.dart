import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sgdvl_model.freezed.dart';
part 'sgdvl_model.g.dart';

@freezed
class SGDVL with _$SGDVL {
  const factory SGDVL({
    required int id,
    required String pgdTen,
    required String pgdNgay,
    required String pgdGio,
    required String pgdDiadiem,
    required int displayOrder,
    required String createdDate,
    required String createdBy,
    required String modifiredDate,
    required String modifiredBy,
    required bool duyet,
    required String nguoiduyet,
    required bool status,
    required int tongsoDndk,
    required int soDnPhongvan,
    required int soDnUyquyenPv,
    required int tongNhucauTd,
    required int nhucautrongtinh,
    required int nhucauNgoaitinh,
    required int nhucauNgoainuoc,
    required int nhucauTdldCotrinhdo,
    required int nhucauTdpt,
    required int soUvDangkyPgd,
    required int soUvThamgiaPgd,
    required int soUvDuoctuvan,
    required int soUvDuocPv,
    int? soUvDatsotuyen,
    required int trongdoUvNu,
    required int soLdCotrinhdoDatsotuyen,
    required int soLdptDatsotuyen,
    required int soLDhenphongvan,
    required int songuoiDkxkld,
    dynamic soketnoiThanhcong,
    String? ghichu,
    required String matinh,
  }) = _SGDVL;

  factory SGDVL.fromJson(Map<String, dynamic> json) => _$SGDVLFromJson(json);
}
