import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class NguyenNhanThatNghiep extends GenericPickerItem {
  final String? code;
  final int? order;
  final bool? status;

  NguyenNhanThatNghiep({
    required int super.id,
    required String name,
    this.code,
    this.order,
    this.status,
  }) : super(displayName: name);

  factory NguyenNhanThatNghiep.fromJson(Map<String, dynamic> json) {
    return NguyenNhanThatNghiep(
      id: json['id'],
      name: json['name'] ?? '',
      code: json['code'],
      order: json['order'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'code': code,
      'order': order,
      'status': status,
    };
  }
}
