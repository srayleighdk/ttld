import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class QuocGia extends GenericPickerItem {
  final String viettat;
  final int displayOrder;
  final bool status;

  QuocGia({
    required int id,
    required String name,
    required this.viettat,
    required this.displayOrder,
    required this.status,
  }) : super(id: id, displayName: name);

  factory QuocGia.fromJson(Map<String, dynamic> json) {
    return QuocGia(
      id: json['id'],
      name: json['name'] ?? '',
      viettat: json['viettat'] ?? '',
      displayOrder: json['displayOrder'] ?? 0,
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'viettat': viettat,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
