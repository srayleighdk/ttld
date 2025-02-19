import 'package:freezed_annotation/freezed_annotation.dart';

part 'vieclam_ungvien_model.freezed.dart';
part 'vieclam_ungvien_model.g.dart';

@freezed
class TblViecLamUngVienModel with _$TblViecLamUngVienModel {
  factory TblViecLamUngVienModel({
    @JsonKey(name: 'IdVL') int? idVL,
    @JsonKey(name: 'Iduv') int? iduv,
    @JsonKey(name: 'Maphieu') String? maphieu,
    @JsonKey(name: 'Ngaylap') DateTime? ngaylap,
    @JsonKey(name: 'IdNguoiduyet') String? idNguoiduyet,
    @JsonKey(name: 'MaCV') String? maCV,
    @JsonKey(name: 'MasoLD') String? masoLD,
    @JsonKey(name: 'IdLoaiDN') int? idLoaiDN,
    @JsonKey(name: 'IdTinh') String? idTinh,
    @JsonKey(name: 'Idhuyen') String? idhuyen,
    @JsonKey(name: 'Idxa') String? idxa,
    @JsonKey(name: 'DiachiLV') String? diachiLV,
    @JsonKey(name: 'IdDN') int? idDN,
    @JsonKey(name: 'IdKhuVuc') int? idKhuVuc,
    @JsonKey(name: 'IdNKT') String? idNKT,
    @JsonKey(name: 'IdLoaiHD') String? idLoaiHD,
    @JsonKey(name: 'Tencongviec') String? tencongviec,
    @JsonKey(name: 'MatVL') bool? matVL,
    @JsonKey(name: 'NgaymatVL') DateTime? ngaymatVL,
    @JsonKey(name: 'Diengiai') String? diengiai,
    @JsonKey(name: 'Ghichu') String? ghichu,
    @JsonKey(name: 'Status') bool? status,
    @JsonKey(name: 'DisplayOrder') int? displayOrder,
    @JsonKey(name: 'CreatedDate') DateTime? createdDate,
    @JsonKey(name: 'CreatedBy') String? createdBy,
    @JsonKey(name: 'ModifiredDate') DateTime? modifiredDate,
    @JsonKey(name: 'ModifiredBy') String? modifiredBy,
  }) = _TblViecLamUngVienModel;

  factory TblViecLamUngVienModel.fromJson(Map<String, dynamic> json) =>
      _$TblViecLamUngVienModelFromJson(json);
}
