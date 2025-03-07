import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class NganhNgheTD extends GenericPickerItem {
  final String manhom;
  final int displayOrder;
  final bool status;

  NganhNgheTD({
    required int id,
    required String name,
    required this.manhom,
    required this.displayOrder,
    required this.status,
  }) : super(id: id, displayName: name);

  factory NganhNgheTD.fromJson(Map<String, dynamic> json) {
    return NganhNgheTD(
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
