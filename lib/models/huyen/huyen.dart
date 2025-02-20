import 'package:freezed_annotation/freezed_annotation.dart';

part 'huyen.freezed.dart';

@freezed
class Huyen with _$Huyen {
  factory Huyen({
    required String mahuyen,
    required String tenhuyen,
    required int sott,
    required bool show,
    required String tentinh,
  }) = _Huyen;

  factory Huyen.fromJson(Map<String, dynamic> json) => _$HuyenFromJson(json);
}
