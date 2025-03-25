// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      idUser: json['idUser'] as String,
      idUserGroup: json['idUserGroup'] as String,
      manv: json['manv'] as String?,
      userName: json['userName'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      modifiredDate: json['modifiredDate'] == null
          ? null
          : DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String?,
      status: json['status'] as bool,
      isAdmin: json['isAdmin'] as bool,
      duyetbientap: json['duyetbientap'] as bool?,
      duyetchuyentin: json['duyetchuyentin'] as bool?,
      duyetcapphong: json['duyetcapphong'] as bool?,
      duyetgiamdoc: json['duyetgiamdoc'] as bool?,
      idCapduyet: (json['idCapduyet'] as num?)?.toInt(),
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'idUserGroup': instance.idUserGroup,
      'manv': instance.manv,
      'userName': instance.userName,
      'password': instance.password,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'displayOrder': instance.displayOrder,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiredDate': instance.modifiredDate?.toIso8601String(),
      'modifiredBy': instance.modifiredBy,
      'status': instance.status,
      'isAdmin': instance.isAdmin,
      'duyetbientap': instance.duyetbientap,
      'duyetchuyentin': instance.duyetchuyentin,
      'duyetcapphong': instance.duyetcapphong,
      'duyetgiamdoc': instance.duyetgiamdoc,
      'idCapduyet': instance.idCapduyet,
      'birthday': instance.birthday?.toIso8601String(),
    };
