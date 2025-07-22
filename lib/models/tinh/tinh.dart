// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'tinh.freezed.dart';
// part 'tinh.g.dart';
//
// @freezed
// class Tinh with _$Tinh {
//   factory Tinh({
//     @Default(0) int displayOrder,
//     @Default('') String matinh,
//     @Default('') String tentinh,
//     @Default('') String mabhyt,
//     @Default(false) bool show,
//   }) = _Tinh;
//
//   factory Tinh.fromJson(Map<String, dynamic> json) => _$TinhFromJson(json);
// }

import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class Tinh extends GenericPickerItem {
  final int displayOrder;
  final String mabhyt;
  final bool show;

  Tinh({
    required String matinh,
    required String tentinh,
    required this.mabhyt,
    required this.displayOrder,
    required this.show,
  }) : super(id: matinh, displayName: tentinh);

  factory Tinh.fromJson(Map<String, dynamic> json) {
    return Tinh(
      matinh: json['matinh'] ?? '',
      tentinh: json['tentinh'] ?? '',
      mabhyt: json['mabhyt'] ?? '',
      displayOrder: json['displayOrder'] ?? 0,
      show: json['show'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matinh': id,
      'tentinh': displayName,
      'displayOrder': displayOrder,
      'mabhyt': mabhyt,
      'show': show,
    };
  }
}
