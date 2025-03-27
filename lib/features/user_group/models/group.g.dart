// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      idUserGroup: json['idUserGroup'] as String,
      parentId: json['parentId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      groupLevel: (json['groupLevel'] as num?)?.toInt() ?? 1,
      status: json['status'] as bool? ?? true,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'idUserGroup': instance.idUserGroup,
      'parentId': instance.parentId,
      'name': instance.name,
      'description': instance.description,
      'users': instance.users,
      'displayOrder': instance.displayOrder,
      'groupLevel': instance.groupLevel,
      'status': instance.status,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
    };
