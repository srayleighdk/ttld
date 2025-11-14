import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// Model for TblDmBacMonDaoTao (Bậc môn đào tạo)
/// Used by API: GET /common/bac-hoc
class BacMonDaoTao extends GenericPickerItem {
  final String? description;
  final String idNhom;
  final int? ordinalNumbers;
  final bool? status;

  BacMonDaoTao({
    required String idBacHoc,
    this.description,
    required this.idNhom,
    this.ordinalNumbers,
    this.status,
  }) : super(id: idBacHoc, displayName: description ?? idBacHoc);

  factory BacMonDaoTao.fromJson(Map<String, dynamic> json) {
    return BacMonDaoTao(
      idBacHoc: json['idBacHoc'] ?? json['IdBacHoc'] ?? '',
      description: json['description'] ?? json['Description'],
      idNhom: json['idNhom'] ?? json['IdNhom'] ?? '',
      ordinalNumbers: json['ordinalNumbers'] ?? json['OrdinalNumbers'],
      status: json['status'] ?? json['Status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBacHoc': id,
      'description': description,
      'idNhom': idNhom,
      'ordinalNumbers': ordinalNumbers,
      'status': status,
    };
  }
}
