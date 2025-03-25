import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class HinhThucTuyenDung extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  HinhThucTuyenDung({
    required super.id,
    required String ten,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: ten);

  factory HinhThucTuyenDung.fromJson(Map<String, dynamic> json) {
    return HinhThucTuyenDung(
      id: json['id'],
      ten: json['ten'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
