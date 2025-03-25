import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String idUser,
    required String idUserGroup,
    String? manv,
    required String userName,
    required String password,
    required String name,
    String? phone,
    String? email,
    String? address,
    int? displayOrder,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
    required bool status,
    required bool isAdmin,
    bool? duyetbientap,
    bool? duyetchuyentin,
    bool? duyetcapphong,
    bool? duyetgiamdoc,
    int? idCapduyet,
    DateTime? birthday,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
