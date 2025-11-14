import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class CaLamViec extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  CaLamViec({
    required int super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory CaLamViec.fromJson(Map<String, dynamic> json) {
    return CaLamViec(
      id: json['ma'],
      name: json['ten'],
      displayOrder: json['displayOrder'] ?? 0,
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ma': id,
      'ten': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
