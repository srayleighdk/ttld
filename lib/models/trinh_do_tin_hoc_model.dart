import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class TrinhDoTinHoc extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  TrinhDoTinHoc({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }): super(displayName: name);

  factory TrinhDoTinHoc.fromJson(Map<String, dynamic> json) {
    return TrinhDoTinHoc(
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
