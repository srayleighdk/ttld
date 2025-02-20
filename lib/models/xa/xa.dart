import 'package:freezed_annotation/freezed_annotation.dart';

part 'xa.freezed.dart';

@freezed
class Xa with _$Xa {
  factory Xa({
    required int sott,
    required int kind,
    required String maxa,
    required String tenxa,
    required String matinh,
    required bool show,
    required String mahuyen,
    required String tenhuyen,
    required String tentinh,
  }) = _Xa;

  factory Xa.fromJson(Map<String, dynamic> json) => _$XaFromJson(json);
}
