import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// Model for TblDmStatusDG (Mức độ ngoại ngữ - Language proficiency level)
/// Used by API: GET /common/status-dg
class StatusDg extends GenericPickerItem {
  StatusDg({
    required int id,
    required String ten,
  }) : super(id: id, displayName: ten);

  factory StatusDg.fromJson(Map<String, dynamic> json) {
    return StatusDg(
      id: json['id'] ?? 0,
      ten: json['ten'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': displayName,
    };
  }
}
