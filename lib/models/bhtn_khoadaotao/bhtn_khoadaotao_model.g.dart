// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bhtn_khoadaotao_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BhtnKhoadaotaoImpl _$$BhtnKhoadaotaoImplFromJson(Map<String, dynamic> json) =>
    _$BhtnKhoadaotaoImpl(
      idKhoadaotao: (json['IdKhoadaotao'] as num?)?.toInt(),
      idcosodaotao: (json['Idcosodaotao'] as num?)?.toInt(),
      name: json['Name'] as String?,
      idBhtn: json['IDBhtn'] as String?,
      hocphi: (json['Hocphi'] as num?)?.toDouble(),
      sothangdaotao: (json['Sothangdaotao'] as num?)?.toDouble(),
      displayOrder: (json['DisplayOrder'] as num?)?.toInt(),
      status: json['Status'] as bool?,
      portalId: (json['PortalID'] as num?)?.toInt(),
      updated: json['Updated'] == null
          ? null
          : DateTime.parse(json['Updated'] as String),
      isDeleted: json['IsDeleted'] as bool?,
    );

Map<String, dynamic> _$$BhtnKhoadaotaoImplToJson(
        _$BhtnKhoadaotaoImpl instance) =>
    <String, dynamic>{
      'IdKhoadaotao': instance.idKhoadaotao,
      'Idcosodaotao': instance.idcosodaotao,
      'Name': instance.name,
      'IDBhtn': instance.idBhtn,
      'Hocphi': instance.hocphi,
      'Sothangdaotao': instance.sothangdaotao,
      'DisplayOrder': instance.displayOrder,
      'Status': instance.status,
      'PortalID': instance.portalId,
      'Updated': instance.updated?.toIso8601String(),
      'IsDeleted': instance.isDeleted,
    };
