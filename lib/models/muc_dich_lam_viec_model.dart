import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class MucDichLamViec extends GenericPickerItem {
  final String name;
  final String idhinhthuclamviec;
  final int displayOrder;
  final bool status;

  MucDichLamViec({
    required super.id,
    required String ten,
    required this.name,
    required this.idhinhthuclamviec,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: ten);

  factory MucDichLamViec.fromJson(Map<String, dynamic> json) {
    return MucDichLamViec(
      id: json['id'],
      ten: json['ten'],
      name: json['name'],
      idhinhthuclamviec: json['idhinhthuclamviec'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': displayName,
      'name': name,
      'idhinhthuclamviec': idhinhthuclamviec,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
