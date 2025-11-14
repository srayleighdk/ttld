import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class DmTinhMoi extends GenericPickerItem {
  @override
  final int id;
  final String code;
  final String? tentinh;
  final String? oldcode;
  final bool status;

  DmTinhMoi({
    required this.id,
    required this.code,
    this.tentinh,
    this.oldcode,
    this.status = false,
  }) : super(id: id, displayName: tentinh ?? '');

  factory DmTinhMoi.fromJson(Map<String, dynamic> json) {
    return DmTinhMoi(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      tentinh: json['tentinh'],
      oldcode: json['oldcode'],
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'tentinh': tentinh,
      'oldcode': oldcode,
      'status': status,
    };
  }

  @override
  String get displayName => tentinh ?? '';
}
