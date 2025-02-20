// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'huyen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HuyenImpl _$$HuyenImplFromJson(Map<String, dynamic> json) => _$HuyenImpl(
      mahuyen: json['mahuyen'] as String,
      tenhuyen: json['tenhuyen'] as String,
      sott: (json['sott'] as num).toInt(),
      show: json['show'] as bool,
      tentinh: json['tentinh'] as String,
    );

Map<String, dynamic> _$$HuyenImplToJson(_$HuyenImpl instance) =>
    <String, dynamic>{
      'mahuyen': instance.mahuyen,
      'tenhuyen': instance.tenhuyen,
      'sott': instance.sott,
      'show': instance.show,
      'tentinh': instance.tentinh,
    };
