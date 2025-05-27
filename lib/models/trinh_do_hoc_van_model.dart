import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class TrinhDoHocVan extends GenericPickerItem {
  int? displayOrder;
  int? idCaphoc;
  String? phanloai;
  bool? status;

  TrinhDoHocVan({
    required super.id,
    required String name,
    this.displayOrder,
    this.idCaphoc,
    this.phanloai,
    this.status,
  }) : super(displayName: name);

  factory TrinhDoHocVan.fromJson(Map<String, dynamic> json) {
    return TrinhDoHocVan(
      id: json['id'],
      name: json['name'],
      displayOrder: json['displayOrder'],
      idCaphoc: json['idCaphoc'],
      phanloai: json['phanloai'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'displayOrder': displayOrder,
      'idCaphoc': idCaphoc,
      'phanloai': phanloai,
      'status': status,
    };
  }
}
