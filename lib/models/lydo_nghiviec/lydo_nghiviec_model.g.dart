// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lydo_nghiviec_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LydoNghiviecImpl _$$LydoNghiviecImplFromJson(Map<String, dynamic> json) =>
    _$LydoNghiviecImpl(
      id: (json['id'] as num?)?.toInt(),
      ten: json['ten'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$LydoNghiviecImplToJson(_$LydoNghiviecImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ten': instance.ten,
      'displayOrder': instance.displayOrder,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
      'status': instance.status,
    };
