import 'package:freezed_annotation/freezed_annotation.dart';

part 'tttantat.freezed.dart';
part 'tttantat.g.dart';

@freezed
abstract class TinhTrangTanTat with _$TinhTrangTanTat {
  factory TinhTrangTanTat(
    @JsonKey(name: 'tantat_id') int tantatId,
    @JsonKey(name: 'tantat_ten') String tantatTen,
    @JsonKey(name: 'DisplayOrder') int displayOrder,
    @JsonKey(name: 'Status') bool status,
  ) = _TinhTrangTanTat;

  factory TinhTrangTanTat.fromJson(Map<String, dynamic> json) => _$TinhTrangTanTatFromJson(json);
}
