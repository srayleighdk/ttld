import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class TonGiao extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  TonGiao({
    required super.id,
    required String name,
    required this.displayOrder,
    required this.status,
  }) : super(displayName: name);

  factory TonGiao.fromJson(Map<String, dynamic> json) {
    return TonGiao(
      id: json['id'] ?? json['idTg'],
      name: json['tenTg'] ?? json['name'] ?? '',
      displayOrder: json['displayOrder'] ?? 0,
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenTg': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
