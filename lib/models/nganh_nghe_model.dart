import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class NganhNgheKT extends GenericPickerItem {
  final String manhom;
  final int displayOrder;
  final bool status;

  NganhNgheKT({
    required String id,
    required String name,
    required this.manhom,
    required this.displayOrder,
    required this.status,
  }) : super(id: id, displayName: name);

  factory NganhNgheKT.fromJson(Map<String, dynamic> json) {
    return NganhNgheKT(
      id: json['id'],
      name: json['name'],
      manhom: json['manhom'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'manhom': manhom,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
