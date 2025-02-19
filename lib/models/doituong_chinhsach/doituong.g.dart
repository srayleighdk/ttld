// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doituong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoiTuongChinhSachImpl _$$DoiTuongChinhSachImplFromJson(
        Map<String, dynamic> json) =>
    _$DoiTuongChinhSachImpl(
      (json['dtcs_id'] as num).toInt(),
      json['dtcs_ten'] as String?,
      (json['DisplayOrder'] as num).toInt(),
      json['Status'] as bool,
    );

Map<String, dynamic> _$$DoiTuongChinhSachImplToJson(
        _$DoiTuongChinhSachImpl instance) =>
    <String, dynamic>{
      'dtcs_id': instance.dtcsId,
      'dtcs_ten': instance.dtcsTen,
      'DisplayOrder': instance.displayOrder,
      'Status': instance.status,
    };
