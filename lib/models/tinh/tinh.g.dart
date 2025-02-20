// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tinh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TinhImpl _$$TinhImplFromJson(Map<String, dynamic> json) => _$TinhImpl(
      displayOrder: (json['displayOrder'] as num).toInt(),
      matinh: json['matinh'] as String,
      tentinh: json['tentinh'] as String,
      mabhyt: json['mabhyt'] as String,
      show: json['show'] as bool,
    );

Map<String, dynamic> _$$TinhImplToJson(_$TinhImpl instance) =>
    <String, dynamic>{
      'displayOrder': instance.displayOrder,
      'matinh': instance.matinh,
      'tentinh': instance.tentinh,
      'mabhyt': instance.mabhyt,
      'show': instance.show,
    };
