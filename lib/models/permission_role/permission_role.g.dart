// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PermissionRoleImpl _$$PermissionRoleImplFromJson(Map<String, dynamic> json) =>
    _$PermissionRoleImpl(
      idOrder: (json['idOrder'] as num?)?.toInt(),
      idMenu: json['idMenu'] as String?,
      groupLevel: (json['groupLevel'] as num?)?.toInt(),
      description: json['description'] as String?,
      idController: json['idController'] as String?,
      idAction: json['idAction'] as String?,
      controllerActive: json['controllerActive'] as String?,
      href: json['href'] as bool?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
      status: json['status'] as bool?,
      showOnline: json['showOnline'] as bool?,
      parentId: json['parentId'] as String?,
      executeSelect: json['executeSelect'] as bool?,
      executeInsert: json['executeInsert'] as bool?,
      executeUpdate: json['executeUpdate'] as bool?,
      executeDelete: json['executeDelete'] as bool?,
      executeDuyet: json['executeDuyet'] as bool?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => PermissionRole.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PermissionRoleImplToJson(
        _$PermissionRoleImpl instance) =>
    <String, dynamic>{
      'idOrder': instance.idOrder,
      'idMenu': instance.idMenu,
      'groupLevel': instance.groupLevel,
      'description': instance.description,
      'idController': instance.idController,
      'idAction': instance.idAction,
      'controllerActive': instance.controllerActive,
      'href': instance.href,
      'displayOrder': instance.displayOrder,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
      'status': instance.status,
      'showOnline': instance.showOnline,
      'parentId': instance.parentId,
      'executeSelect': instance.executeSelect,
      'executeInsert': instance.executeInsert,
      'executeUpdate': instance.executeUpdate,
      'executeDelete': instance.executeDelete,
      'executeDuyet': instance.executeDuyet,
      'children': instance.children,
    };
