import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class ThoiGianLamViec extends GenericPickerItem {
  final String idhinhthuclamviec;
  final int displayOrder;
  final bool status;

  ThoiGianLamViec({
    required super.id,
    required String name,
    required this.idhinhthuclamviec,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory ThoiGianLamViec.fromJson(Map<String, dynamic> json) {
    return ThoiGianLamViec(
      id: json['id'],
      name: json['name'],
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
