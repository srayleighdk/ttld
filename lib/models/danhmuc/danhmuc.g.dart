// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danhmuc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DanhMucImpl _$$DanhMucImplFromJson(Map<String, dynamic> json) =>
    _$DanhMucImpl(
      (json['ma_chuc_danh'] as num).toInt(),
      json['ten_chuc_danh'] as String,
      (json['DisplayOrder'] as num).toInt(),
      json['Status'] as bool,
      (json['idLoai'] as num).toInt(),
    );

Map<String, dynamic> _$$DanhMucImplToJson(_$DanhMucImpl instance) =>
    <String, dynamic>{
      'ma_chuc_danh': instance.maChucDanh,
      'ten_chuc_danh': instance.tenChucDanh,
      'DisplayOrder': instance.displayOrder,
      'Status': instance.status,
      'idLoai': instance.idLoai,
    };
