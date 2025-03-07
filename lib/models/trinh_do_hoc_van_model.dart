import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class TrinhDoHocVan extends GenericPickerItem {

  final int displayOrder;
  final int idCaphoc;
  final String phanloai;
  final bool status;

  TrinhDoHocVan({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.idCaphoc,
    required this.phanloai,
    required this.status,
  }): super(displayName: name);

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