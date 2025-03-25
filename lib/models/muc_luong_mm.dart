import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class MucLuongMM extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  MucLuongMM({
    required int idMucLuong,
    required String tenMucLuong,
    required this.displayOrder,
    required this.status,
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
