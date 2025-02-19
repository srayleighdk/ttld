import 'package:freezed_annotation/freezed_annotation.dart';

part 'danhmuc.freezed.dart';
part 'danhmuc.g.dart';

@freezed
abstract class DanhMuc with _$DanhMuc {
  factory DanhMuc(
    @JsonKey(name: 'ma_chuc_danh') int maChucDanh,
    @JsonKey(name: 'ten_chuc_danh') String tenChucDanh,
    @JsonKey(name: 'DisplayOrder') int displayOrder,
    @JsonKey(name: 'Status') bool status,
    @JsonKey(name: 'idLoai') int idLoai,
  ) = _DanhMuc;

  factory DanhMuc.fromJson(Map<String, dynamic> json) =>
      _$DanhMucFromJson(json);
}
