// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$XaImpl _$$XaImplFromJson(Map<String, dynamic> json) => _$XaImpl(
      sott: (json['sott'] as num).toInt(),
      kind: (json['kind'] as num).toInt(),
      maxa: json['maxa'] as String,
      tenxa: json['tenxa'] as String,
      matinh: json['matinh'] as String,
      show: json['show'] as bool,
      mahuyen: json['mahuyen'] as String,
      tenhuyen: json['tenhuyen'] as String,
      tentinh: json['tentinh'] as String,
    );

Map<String, dynamic> _$$XaImplToJson(_$XaImpl instance) => <String, dynamic>{
      'sott': instance.sott,
      'kind': instance.kind,
      'maxa': instance.maxa,
      'tenxa': instance.tenxa,
      'matinh': instance.matinh,
      'show': instance.show,
      'mahuyen': instance.mahuyen,
      'tenhuyen': instance.tenhuyen,
      'tentinh': instance.tentinh,
    };
