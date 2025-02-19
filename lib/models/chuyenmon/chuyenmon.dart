import 'package:freezed_annotation/freezed_annotation.dart';

part 'chuyenmon.freezed.dart';
part 'chuyenmon.g.dart';

@freezed
abstract class ChuyenMon with _$ChuyenMon {
  factory ChuyenMon(
    @JsonKey(name: 'ma_chuyen_mon') int maChuyenMon,
    @JsonKey(name: 'ten_chuyen_mon') String tenChuyenMon,
    @JsonKey(name: 'DisplayOrder') int displayOrder,
    @JsonKey(name: 'Status') bool status,
  ) = _ChuyenMon;

  factory ChuyenMon.fromJson(Map<String, dynamic> json) => _$ChuyenMonFromJson(json);
}
