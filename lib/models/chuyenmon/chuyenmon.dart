import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class ChuyenMon extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  ChuyenMon({
    required int super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory ChuyenMon.fromJson(Map<String, dynamic> json) {
    return ChuyenMon(
      id: json['maChuyenMon'] ?? json['ma_chuyen_mon'] ?? json['id'] ?? 0,
      name: json['tenChuyenMon'] ?? json['ten_chuyen_mon'] ?? json['name'] ?? '',
      displayOrder: json['displayOrder'] ?? json['DisplayOrder'] ?? 0,
      status: json['status'] ?? json['Status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ma_chuyen_mon': id,
      'ten_chuyen_mon': displayName,
      'DisplayOrder': displayOrder,
      'Status': status,
    };
  }
}
