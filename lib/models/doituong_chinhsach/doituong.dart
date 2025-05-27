import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class DoiTuong extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  DoiTuong({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory DoiTuong.fromJson(Map<String, dynamic> json) {
    return DoiTuong(
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
