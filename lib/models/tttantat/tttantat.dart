import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class TtTantat extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  TtTantat({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory TtTantat.fromJson(Map<String, dynamic> json) {
    return TtTantat(
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
