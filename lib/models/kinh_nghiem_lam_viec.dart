import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class KinhNghiemLamViec extends GenericPickerItem {
  final String idhinhthuclamviec;
  final int displayOrder;
  final bool status;

  KinhNghiemLamViec({
    required super.id,
    required String ten,
    required this.idhinhthuclamviec,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: ten);

  factory KinhNghiemLamViec.fromJson(Map<String, dynamic> json) {
    return KinhNghiemLamViec(
      id: json['id'],
      ten: json['name'],
      idhinhthuclamviec: json['idhinhthuclamviec'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': displayName,
      'idhinhthuclamviec': idhinhthuclamviec,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
