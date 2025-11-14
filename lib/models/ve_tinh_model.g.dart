// GENERATED CODE - DO NOT MODIFY BY HAND

part of 've_tinh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VeTinhImpl _$$VeTinhImplFromJson(Map<String, dynamic> json) => _$VeTinhImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      status: json['status'] as bool?,
      parentId: json['parentId'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$VeTinhImplToJson(_$VeTinhImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'displayOrder': instance.displayOrder,
      'status': instance.status,
      'parentId': instance.parentId,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };
