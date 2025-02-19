import 'package:freezed_annotation/freezed_annotation.dart';

part 'doituong.freezed.dart';
part 'doituong.g.dart';

@freezed
abstract class DoiTuongChinhSach with _$DoiTuongChinhSach {
  factory DoiTuongChinhSach(
    @JsonKey(name: 'dtcs_id') int dtcsId,
    @JsonKey(name: 'dtcs_ten') String? dtcsTen, // Nullable
    @JsonKey(name: 'DisplayOrder') int displayOrder,
    @JsonKey(name: 'Status') bool status,
  ) = _DoiTuongChinhSach;

  factory DoiTuongChinhSach.fromJson(Map<String, dynamic> json) =>
      _$DoiTuongChinhSachFromJson(json);
}
