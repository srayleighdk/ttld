// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'xa.freezed.dart';
// part 'xa.g.dart';
//
// @freezed
// class Xa with _$Xa {
//   factory Xa({
//     required int sott,
//     required int kind,
//     required String maxa,
//     required String tenxa,
//     required String matinh,
//     required bool show,
//     required String mahuyen,
//     required String tenhuyen,
//     required String tentinh,
//   }) = _Xa;
//
//   factory Xa.fromJson(Map<String, dynamic> json) => _$XaFromJson(json);
// }

import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class Xa extends GenericPickerItem {
  final int sott;
  final int kind;
  final String maxa;
  final String tenxa;
  final String matinh;
  final bool show;
  final String mahuyen;
  final String tenhuyen;
  final String tentinh;

  Xa({
    required this.sott,
    required this.kind,
    required this.maxa,
    required this.tenxa,
    required this.matinh,
    required this.show,
    required this.mahuyen,
    required this.tenhuyen,
    required this.tentinh,
  }) : super(id: maxa, displayName: tenxa);

  factory Xa.fromJson(Map<String, dynamic> json) {
    return Xa(
      sott: json['sott'] ?? 0,
      kind: json['kind'] ?? 0,
      maxa: json['maxa'] ?? '',
      tenxa: json['tenxa'] ?? '',
      matinh: json['matinh'] ?? '',
      show: json['show'] ?? false,
      mahuyen: json['mahuyen'] ?? '',
      tenhuyen: json['tenhuyen'] ?? '',
      tentinh: json['tentinh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sott': sott,
      'kind': kind,
      'maxa': id,
      'tenxa': tenxa,
      'matinh': matinh,
      'show': show,
      'mahuyen': mahuyen,
      'tenhuyen': tenhuyen,
      'tentinh': tentinh,
    };
  }
}
