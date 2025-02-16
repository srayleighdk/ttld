// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      idUserGroup: json['idUserGroup'] as String,
      parentId: json['parentId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      groupLevel: (json['groupLevel'] as num?)?.toInt() ?? 0,
      status: json['status'] as bool? ?? true,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'idUserGroup': instance.idUserGroup,
      'parentId': instance.parentId,
      'name': instance.name,
      'description': instance.description,
      'displayOrder': instance.displayOrder,
      'groupLevel': instance.groupLevel,
      'status': instance.status,
    };
