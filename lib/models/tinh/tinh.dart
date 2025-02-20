import 'package:freezed_annotation/freezed_annotation.dart';

part 'tinh.freezed.dart';
part 'tinh.g.dart';

@freezed
class Tinh with _$Tinh {
  factory Tinh({
    required int displayOrder,
    required String matinh,
    required String tentinh,
    required String mabhyt,
    required bool show,
  }) = _Tinh;

  factory Tinh.fromJson(Map<String, dynamic> json) => _$TinhFromJson(json);
}
