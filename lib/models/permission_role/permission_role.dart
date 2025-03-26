import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_role.freezed.dart';
part 'permission_role.g.dart';

@freezed
class PermissionRole with _$PermissionRole {
  const factory PermissionRole({
    int? idOrder,
    String? idMenu,
    int? groupLevel,
    String? description,
    String? idController,
    String? idAction,
    String? controllerActive,
    bool? href,
    int? displayOrder,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
    bool? status,
    bool? showOnline,
    String? parentId,
    bool? executeSelect,
    bool? executeInsert,
    bool? executeUpdate,
    bool? executeDelete,
    bool? executeDuyet,
    List<PermissionRole>? children,
  }) = _PermissionRole;
  factory PermissionRole.fromJson(Map<String, dynamic> json) =>
      _$PermissionRoleFromJson(json);
}
