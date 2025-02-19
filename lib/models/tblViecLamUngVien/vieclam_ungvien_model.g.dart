// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vieclam_ungvien_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TblViecLamUngVienModelImpl _$$TblViecLamUngVienModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TblViecLamUngVienModelImpl(
      idVL: (json['IdVL'] as num?)?.toInt(),
      iduv: (json['Iduv'] as num?)?.toInt(),
      maphieu: json['Maphieu'] as String?,
      ngaylap: json['Ngaylap'] == null
          ? null
          : DateTime.parse(json['Ngaylap'] as String),
      idNguoiduyet: json['IdNguoiduyet'] as String?,
      maCV: json['MaCV'] as String?,
      masoLD: json['MasoLD'] as String?,
      idLoaiDN: (json['IdLoaiDN'] as num?)?.toInt(),
      idTinh: json['IdTinh'] as String?,
      idhuyen: json['Idhuyen'] as String?,
      idxa: json['Idxa'] as String?,
      diachiLV: json['DiachiLV'] as String?,
      idDN: (json['IdDN'] as num?)?.toInt(),
      idKhuVuc: (json['IdKhuVuc'] as num?)?.toInt(),
      idNKT: json['IdNKT'] as String?,
      idLoaiHD: json['IdLoaiHD'] as String?,
      tencongviec: json['Tencongviec'] as String?,
      matVL: json['MatVL'] as bool?,
      ngaymatVL: json['NgaymatVL'] == null
          ? null
          : DateTime.parse(json['NgaymatVL'] as String),
      diengiai: json['Diengiai'] as String?,
      ghichu: json['Ghichu'] as String?,
      status: json['Status'] as bool?,
      displayOrder: (json['DisplayOrder'] as num?)?.toInt(),
      createdDate: json['CreatedDate'] == null
          ? null
          : DateTime.parse(json['CreatedDate'] as String),
      createdBy: json['CreatedBy'] as String?,
      modifiredDate: json['ModifiredDate'] == null
          ? null
          : DateTime.parse(json['ModifiredDate'] as String),
      modifiredBy: json['ModifiredBy'] as String?,
    );

Map<String, dynamic> _$$TblViecLamUngVienModelImplToJson(
        _$TblViecLamUngVienModelImpl instance) =>
    <String, dynamic>{
      'IdVL': instance.idVL,
      'Iduv': instance.iduv,
      'Maphieu': instance.maphieu,
      'Ngaylap': instance.ngaylap?.toIso8601String(),
      'IdNguoiduyet': instance.idNguoiduyet,
      'MaCV': instance.maCV,
      'MasoLD': instance.masoLD,
      'IdLoaiDN': instance.idLoaiDN,
      'IdTinh': instance.idTinh,
      'Idhuyen': instance.idhuyen,
      'Idxa': instance.idxa,
      'DiachiLV': instance.diachiLV,
      'IdDN': instance.idDN,
      'IdKhuVuc': instance.idKhuVuc,
      'IdNKT': instance.idNKT,
      'IdLoaiHD': instance.idLoaiHD,
      'Tencongviec': instance.tencongviec,
      'MatVL': instance.matVL,
      'NgaymatVL': instance.ngaymatVL?.toIso8601String(),
      'Diengiai': instance.diengiai,
      'Ghichu': instance.ghichu,
      'Status': instance.status,
      'DisplayOrder': instance.displayOrder,
      'CreatedDate': instance.createdDate?.toIso8601String(),
      'CreatedBy': instance.createdBy,
      'ModifiredDate': instance.modifiredDate?.toIso8601String(),
      'ModifiredBy': instance.modifiredBy,
    };
