// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chuyenmon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChuyenMonImpl _$$ChuyenMonImplFromJson(Map<String, dynamic> json) =>
    _$ChuyenMonImpl(
      (json['ma_chuyen_mon'] as num).toInt(),
      json['ten_chuyen_mon'] as String,
      (json['DisplayOrder'] as num).toInt(),
      json['Status'] as bool,
    );

Map<String, dynamic> _$$ChuyenMonImplToJson(_$ChuyenMonImpl instance) =>
    <String, dynamic>{
      'ma_chuyen_mon': instance.maChuyenMon,
      'ten_chuyen_mon': instance.tenChuyenMon,
      'DisplayOrder': instance.displayOrder,
      'Status': instance.status,
    };
