import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/models/user/user_model.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    required String idUserGroup,
    String? parentId,
    String? name,
    String? description,
    @Default([]) List<UserModel> users,
    @Default(0) int displayOrder,
    @Default(1) int groupLevel,
    @Default(true) bool status,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
