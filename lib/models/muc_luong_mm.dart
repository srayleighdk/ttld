import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class MucLuongMM extends GenericPickerItem {
  int? displayOrder;
  bool? status;

  MucLuongMM({
    required int idMucLuong,
    required String tenMucLuong,
    this.displayOrder,
    this.status,
  }) : super(id: idMucLuong, displayName: tenMucLuong);

  factory MucLuongMM.fromJson(Map<String, dynamic> json) {
    return MucLuongMM(
      idMucLuong: json['idMucLuong'],
      tenMucLuong: json['tenMucLuong'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMucLuong': id,
      'tenMucLuong': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
