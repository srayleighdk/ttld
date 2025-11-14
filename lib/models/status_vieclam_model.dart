import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// Model for TblDmStatusViecLam (Employment Status)
/// Used by API: GET /common/status-vl
class StatusViecLam extends GenericPickerItem {
  final int? displayOrder;
  final bool? status;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? modifiredDate;
  final String? modifiredBy;

  StatusViecLam({
    required super.id,
    required String ten,
    this.displayOrder,
    this.status,
    this.createdDate,
    this.createdBy,
    this.modifiredDate,
    this.modifiredBy,
  }) : super(displayName: ten);

  // Backward compatibility getter
  String get ten => displayName;

  factory StatusViecLam.fromJson(Map<String, dynamic> json) {
    return StatusViecLam(
      id: json['id'],
      ten: json['ten'] ?? '',
      displayOrder: json['displayOrder'],
      status: json['status'],
      createdDate: json['createdDate'] != null
          ? DateTime.tryParse(json['createdDate'])
          : null,
      createdBy: json['createdBy'],
      modifiredDate: json['modifiredDate'] != null
          ? DateTime.tryParse(json['modifiredDate'])
          : null,
      modifiredBy: json['modifiredBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': displayName,
      'displayOrder': displayOrder,
      'status': status,
      'createdDate': createdDate?.toIso8601String(),
      'createdBy': createdBy,
      'modifiredDate': modifiredDate?.toIso8601String(),
      'modifiredBy': modifiredBy,
    };
  }
}
