import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class HinhThucDoanhNghiep extends GenericPickerItem {
  final String idLhdn;
  final int displayOrder;
  final bool status;

  HinhThucDoanhNghiep({
    required super.id,
    required String name,
    required this.idLhdn,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory HinhThucDoanhNghiep.fromJson(Map<String, dynamic> json) {
    return HinhThucDoanhNghiep(
      id: json['id'],
      name: json['name'],
      idLhdn: json['idLhdn'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'idLhdn': idLhdn,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
