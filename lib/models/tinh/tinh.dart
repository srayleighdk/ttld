import 'package:freezed_annotation/freezed_annotation.dart';

part 'tinh.freezed.dart';
part 'tinh.g.dart';

@freezed
class Tinh with _$Tinh {
  factory Tinh({
    @Default(0) int displayOrder,
    @Default('') String matinh,
    @Default('') String tentinh,
    @Default('') String mabhyt,
    @Default(false) bool show,
  }) = _Tinh;

  factory Tinh.fromJson(Map<String, dynamic> json) => _$TinhFromJson(json);
}
