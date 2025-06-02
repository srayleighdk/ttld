import 'package:freezed_annotation/freezed_annotation.dart';

part 'uv_dk_sgd_model.freezed.dart';
part 'uv_dk_sgd_model.g.dart';

@freezed
class UvDkSGD with _$UvDkSGD {
  const factory UvDkSGD({
    required String idUngvien,
    required int idPhienGd,
    required String ngaydk,
    required String ngayPgd,
    String? listIdDn,
    required String tieude,
    String? noidung,
    required String email,
    String? filemail,
    required bool duyet,
    int? status,
    required bool isThamgia,
    int? displayOrder,
    required String createdDate,
    required String createdBy,
    required String modifiredDate,
    required String modifiredBy,
  }) = _UvDkSGD;

  factory UvDkSGD.fromJson(Map<String, dynamic> json) => _$UvDkSGDFromJson(json);
} 