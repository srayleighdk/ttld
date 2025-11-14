import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class DmXaMoi extends GenericPickerItem {
  @override
  final int id;
  final String code;
  final String? ten;
  final String? oldcode;
  final int? idKhuVuc;
  final bool status;
  final bool activate;
  final int? idTinh;
  final String? tentinh;

  DmXaMoi({
    required this.id,
    required this.code,
    this.ten,
    this.oldcode,
    this.idKhuVuc,
    this.status = false,
    this.activate = false,
    this.idTinh,
    this.tentinh,
  }) : super(id: id, displayName: ten ?? '');

  factory DmXaMoi.fromJson(Map<String, dynamic> json) {
    return DmXaMoi(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      ten: json['ten'],
      oldcode: json['oldcode'],
      idKhuVuc: json['idKhuVuc'],
      status: json['status'] ?? false,
      activate: json['activate'] ?? false,
      idTinh: json['idTinh'] is Map ? json['idTinh']['id'] : json['idTinh'],
      tentinh: json['tentinh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'ten': ten,
      'oldcode': oldcode,
      'idKhuVuc': idKhuVuc,
      'status': status,
      'activate': activate,
      'idTinh': idTinh,
      'tentinh': tentinh,
    };
  }

  @override
  String get displayName => ten ?? '';
}
