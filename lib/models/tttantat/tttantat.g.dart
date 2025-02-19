// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tttantat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TinhTrangTanTatImpl _$$TinhTrangTanTatImplFromJson(
        Map<String, dynamic> json) =>
    _$TinhTrangTanTatImpl(
      (json['tantat_id'] as num).toInt(),
      json['tantat_ten'] as String,
      (json['DisplayOrder'] as num).toInt(),
      json['Status'] as bool,
    );

Map<String, dynamic> _$$TinhTrangTanTatImplToJson(
        _$TinhTrangTanTatImpl instance) =>
    <String, dynamic>{
      'tantat_id': instance.tantatId,
      'tantat_ten': instance.tantatTen,
      'DisplayOrder': instance.displayOrder,
      'Status': instance.status,
    };
