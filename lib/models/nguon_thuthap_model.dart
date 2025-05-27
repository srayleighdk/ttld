import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class NguonThuThap extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  NguonThuThap({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory NguonThuThap.fromJson(Map<String, dynamic> json) {
    return NguonThuThap(
      id: json['id'],
      name: json['name'],
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
