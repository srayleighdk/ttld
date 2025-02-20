import 'package:freezed_annotation/freezed_annotation.dart';

part 'tinh.freezed.dart';

@freezed
class Tinh with _$Tinh {
  factory Tinh({
    required String mahuyen,
    required String tenhuyen,
    required int sott,
    required bool show,
    required String tentinh,
  }) = _Tinh;

  factory Tinh.fromJson(Map<String, dynamic> json) => _$TinhFromJson(json);
}
