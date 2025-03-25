import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class TinhTrangHdModel extends GenericPickerItem {
  int? displayOrder;
  bool? status;

  TinhTrangHdModel({
    required super.id,
    required String name,
    this.displayOrder,
    this.status,
  }) : super(displayName: name);

  factory TinhTrangHdModel.fromJson(Map<String, dynamic> json) {
    return TinhTrangHdModel(
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

