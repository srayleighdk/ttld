import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class TrinhDoVanHoa extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  TrinhDoVanHoa({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory TrinhDoVanHoa.fromJson(Map<String, dynamic> json) {
    return TrinhDoVanHoa(
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
