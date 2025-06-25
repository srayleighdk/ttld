// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uv_dk_sgd_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UvDkSGDImpl _$$UvDkSGDImplFromJson(Map<String, dynamic> json) =>
    _$UvDkSGDImpl(
      idUngvien: json['idUngvien'] as String,
      idPhienGd: (json['idPhienGd'] as num).toInt(),
      ngaydk: json['ngaydk'] as String,
      ngayPgd: json['ngayPgd'] as String,
      tieude: json['tieude'] as String,
      noidung: json['noidung'] as String?,
      email: json['email'] as String,
      filemail: json['filemail'] as String?,
      duyet: json['duyet'] as bool,
      status: (json['status'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      createdDate: json['createdDate'] as String,
      createdBy: json['createdBy'] as String,
      modifiredDate: json['modifiredDate'] as String,
      modifiredBy: json['modifiredBy'] as String,
    );

Map<String, dynamic> _$$UvDkSGDImplToJson(_$UvDkSGDImpl instance) =>
    <String, dynamic>{
      'idUngvien': instance.idUngvien,
      'idPhienGd': instance.idPhienGd,
      'ngaydk': instance.ngaydk,
      'ngayPgd': instance.ngayPgd,
      'tieude': instance.tieude,
      'noidung': instance.noidung,
      'email': instance.email,
      'filemail': instance.filemail,
      'duyet': instance.duyet,
      'status': instance.status,
      'displayOrder': instance.displayOrder,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate,
      'modifiredBy': instance.modifiredBy,
    };
