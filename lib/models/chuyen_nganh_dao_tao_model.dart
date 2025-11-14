import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// Model for TblDmBacDaoTaoC3 (Chuyên ngành đào tạo / Bậc đào tạo cấp 3)
/// Used by API: GET /common/chuyen-nganh
class ChuyenNganhDaoTao extends GenericPickerItem {
  final String? idc2;  // Reference to parent level (Bậc 2)
  final String? description;
  final int? displayOrder;
  final bool? status;

  ChuyenNganhDaoTao({
    required String id,
    this.idc2,
    this.description,
    this.displayOrder,
    this.status,
  }) : super(id: id, displayName: description ?? id);

  factory ChuyenNganhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChuyenNganhDaoTao(
      id: json['id'] ?? json['Id'] ?? '',
      idc2: json['idc2'] ?? json['Idc2'],
      description: json['description'] ?? json['Description'],
      displayOrder: json['displayOrder'] ?? json['DisplayOrder'],
      status: json['status'] ?? json['Status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idc2': idc2,
      'description': description,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
