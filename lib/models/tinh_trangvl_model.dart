import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class TinhTrangViecLam extends GenericPickerItem {
  final int? displayOrder;
  final bool? status;

  TinhTrangViecLam({
    required super.id,
    required String name,
    this.displayOrder,
    this.status,
  }) : super(displayName: name);

  // Backward compatibility getter
  String get tenTrangThai => displayName;

  factory TinhTrangViecLam.fromJson(Map<String, dynamic> json) {
    return TinhTrangViecLam(
      id: json['id'],
      name: json['name'] ?? json['tenTrangThai'] ?? '',
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'tenTrangThai': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
