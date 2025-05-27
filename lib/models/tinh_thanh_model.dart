import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class TinhThanhModel extends GenericPickerItem {
  int? displayOrder;
  bool? status;
  String? matinh;

  TinhThanhModel({
    required int tpId,
    required String tpTen,
    this.displayOrder,
    this.status,
    this.matinh,
  }) : super(id: tpId, displayName: tpTen);

  factory TinhThanhModel.fromJson(Map<String, dynamic> json) {
    return TinhThanhModel(
      tpId: json['tpId'],
      tpTen: json['tpTen'],
      displayOrder: json['displayOrder'],
      status: json['status'],
      matinh: json['matinh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tpId': id,
      'tpTen': displayName,
      'displayOrder': displayOrder,
      'status': status,
      'matinh': matinh,
    };
  }
}

