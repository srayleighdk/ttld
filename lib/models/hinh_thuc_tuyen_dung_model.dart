import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class HinhThucTuyenDung extends GenericPickerItem {
  final String idhinhthuclamviec;
  final int displayOrder;
  final bool status;

  HinhThucTuyenDung({
    required super.id,
    required String ten,
    required this.idhinhthuclamviec,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: ten);

  factory HinhThucTuyenDung.fromJson(Map<String, dynamic> json) {
    return HinhThucTuyenDung(
      id: json['id'],
      ten: json['ten'],
      idhinhthuclamviec: json['idhinhthuclamviec'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'idhinhthuclamviec': idhinhthuclamviec,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
