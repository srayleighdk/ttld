import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class NgoaiNgu extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  NgoaiNgu({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory NgoaiNgu.fromJson(Map<String, dynamic> json) {
    return NgoaiNgu(
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
