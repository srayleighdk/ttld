// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chinhsachluong_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChinhSachLuongImpl _$$ChinhSachLuongImplFromJson(Map<String, dynamic> json) =>
    _$ChinhSachLuongImpl(
      id: (json['Id'] as num?)?.toInt(),
      ten: json['ten'] as String?,
      vung: (json['vung'] as num?)?.toInt(),
      salaryMin: (json['salaryMin'] as num?)?.toInt(),
      nldBhxh: (json['nldBhxh'] as num?)?.toDouble(),
      nldBhyt: (json['nldBhyt'] as num?)?.toDouble(),
      nldBhtn: (json['nldBhtn'] as num?)?.toDouble(),
      dnBhxh: (json['dnBhxh'] as num?)?.toDouble(),
      dnBhyt: (json['dnBhyt'] as num?)?.toDouble(),
      dnBhtn: (json['dnBhtn'] as num?)?.toDouble(),
      dnThaisan: (json['dnThaisan'] as num?)?.toDouble(),
      dnTnld: (json['dnTnld'] as num?)?.toDouble(),
      status: json['status'] as bool?,
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
    );

Map<String, dynamic> _$$ChinhSachLuongImplToJson(
        _$ChinhSachLuongImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ten': instance.ten,
      'vung': instance.vung,
      'salaryMin': instance.salaryMin,
      'nldBhxh': instance.nldBhxh,
      'nldBhyt': instance.nldBhyt,
      'nldBhtn': instance.nldBhtn,
      'dnBhxh': instance.dnBhxh,
      'dnBhyt': instance.dnBhyt,
      'dnBhtn': instance.dnBhtn,
      'dnThaisan': instance.dnThaisan,
      'dnTnld': instance.dnTnld,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
    };
