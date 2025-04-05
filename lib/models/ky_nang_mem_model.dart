import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class KyNangMemModel extends GenericPickerItem {
  int? displayOrder;
  bool? status;

  KyNangMemModel({
    required idkn,
    required String ten,
    this.displayOrder,
    this.status,
  }) : super(displayName: ten, id: idkn);

  factory KyNangMemModel.fromJson(Map<String, dynamic> json) {
    return KyNangMemModel(
      idkn: json['id'],
      ten: json['ten'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idkn': id,
      'ten': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
