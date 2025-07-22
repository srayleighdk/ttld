// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

// part 'huyen.freezed.dart';
// part 'huyen.g.dart';
//
// @freezed
// class Huyen with _$Huyen {
//   factory Huyen({
//     required String mahuyen,
//     required String tenhuyen,
//     required int sott,
//     required bool show,
//     required String tentinh,
//   }) = _Huyen;
//
//   factory Huyen.fromJson(Map<String, dynamic> json) => _$HuyenFromJson(json);
// }

class Huyen extends GenericPickerItem {
  final int sott;
  final bool show;
  final String tentinh;

  Huyen({
    required String mahuyen,
    required String tenhuyen,
    required this.sott,
    required this.show,
    required this.tentinh,
  }) : super(id: mahuyen, displayName: tenhuyen);

  factory Huyen.fromJson(Map<String, dynamic> json) {
    return Huyen(
      mahuyen: json['mahuyen'] ?? '',
      tenhuyen: json['tenhuyen'] ?? '',
      sott: json['sott'] ?? 0,
      show: json['show'] ?? false,
      tentinh: json['tentinh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mahuyen': id,
      'tenhuyen': displayName,
      'sott': sott,
      'show': show,
      'tentinh': tentinh,
    };
  }
}
