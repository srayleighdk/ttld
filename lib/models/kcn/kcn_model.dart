import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class KCNModel extends GenericPickerItem {
  final int displayOrder;
  final bool status;
  final String matinh;

  KCNModel({
    required int kcnId,
    required String kcnTen,
    required this.displayOrder,
    required this.status,
    required this.matinh,
  }) : super(id: kcnId, displayName: kcnTen);

  factory KCNModel.fromJson(Map<String, dynamic> json) {
    return KCNModel(
      kcnId: json['kcnId'],
      kcnTen: json['kcnTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
      matinh: json['matinh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kcnId': id,
      'kcnTen': displayName,
      'displayOrder': displayOrder,
      'status': status,
      'matinh': matinh,
    };
  }
}
