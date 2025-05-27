import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class HinhThucLamViecModel extends GenericPickerItem {
  int? displayOrder;
  bool? status;

  HinhThucLamViecModel({
    required super.id,
    required String ten,
    this.displayOrder,
    this.status,
  }) : super(displayName: ten);

  factory HinhThucLamViecModel.fromJson(Map<String, dynamic> json) {
    return HinhThucLamViecModel(
      id: json['id'],
      ten: json['ten'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'ten': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
    return data;
  }
}
