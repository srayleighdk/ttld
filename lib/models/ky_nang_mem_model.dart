import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

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
    final Map<String, dynamic> data = {
      'id': id,
      'ten': displayName,
    };
    if (displayOrder != null) {
      data['displayOrder'] = displayOrder;
    }
    if (status != null) {
      data['status'] = status;
    }
    return data;
  }
}
