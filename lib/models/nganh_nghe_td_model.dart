import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class NganhNgheTD extends GenericPickerItem {
  String? manhom;
  int? displayOrder;
  bool? status;

  NganhNgheTD({
    required super.id,
    required String name,
    this.manhom,
    this.displayOrder,
    this.status,
  }) : super(displayName: name);

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
