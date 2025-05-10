// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapnoi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapNoiModelImpl _$$ChapNoiModelImplFromJson(Map<String, dynamic> json) =>
    _$ChapNoiModelImpl(
      id: (json['id'] as num?)?.toInt(),
      idKieuChapNoi: json['idKieuChapNoi'] as String,
      idUngVien: json['idUngVien'] as String,
      idDoanhNghiep: json['idDoanhNghiep'] as String,
      idTuyenDung: json['idTuyenDung'] as String,
      ngayMuonHs: json['ngayMuonHs'] as String,
      ngayTraHs: json['ngayTraHs'] as String?,
      ghiChu: json['ghiChu'] as String?,
      idKetQua: (json['idKetQua'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] as String?,
      modifiredBy: json['modifiredBy'] as String?,
      tenKieuChapNoi: json['tenKieuChapNoi'] as String?,
      tenUngvien: json['tenUngvien'] as String?,
      sdtUngvien: json['sdtUngvien'] as String?,
      tenDoanhNghiep: json['tenDoanhNghiep'] as String?,
      tenTuyendung: json['tenTuyendung'] as String?,
      tenKetqua: json['tenKetqua'] as String?,
    );

Map<String, dynamic> _$$ChapNoiModelImplToJson(_$ChapNoiModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idKieuChapNoi': instance.idKieuChapNoi,
      'idUngVien': instance.idUngVien,
      'idDoanhNghiep': instance.idDoanhNghiep,
      'idTuyenDung': instance.idTuyenDung,
      'ngayMuonHs': instance.ngayMuonHs,
      'ngayTraHs': instance.ngayTraHs,
      'ghiChu': instance.ghiChu,
      'idKetQua': instance.idKetQua,
      'displayOrder': instance.displayOrder,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate,
      'modifiredBy': instance.modifiredBy,
      'tenKieuChapNoi': instance.tenKieuChapNoi,
      'tenUngvien': instance.tenUngvien,
      'sdtUngvien': instance.sdtUngvien,
      'tenDoanhNghiep': instance.tenDoanhNghiep,
      'tenTuyendung': instance.tenTuyendung,
      'tenKetqua': instance.tenKetqua,
    };
