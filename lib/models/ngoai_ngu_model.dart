import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class NgoaiNgu extends GenericPickerItem {
  final int displayOrder;
  final bool status;

  NgoaiNgu({
    required int maNgoaingudaotao,
    required String tenNgoaingudaotao,
    required this.displayOrder,
    required this.status,
  }) : super(id: maNgoaingudaotao, displayName: tenNgoaingudaotao);

  factory NgoaiNgu.fromJson(Map<String, dynamic> json) {
    return NgoaiNgu(
      maNgoaingudaotao: json['maNgoaingudaotao'],
      tenNgoaingudaotao: json['tenNgoaingudaotao'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maNgoaingudaotao': id,
      'tenNgoaingudaotao': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
