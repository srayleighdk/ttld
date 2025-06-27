import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class DoTuoi extends GenericPickerItem {
  int? displayOrder;
  bool? status;

  DoTuoi({
    required int idDoTuoi,
    required String tenDoTuoi,
    this.displayOrder,
    this.status,
  }) : super(id: idDoTuoi, displayName: tenDoTuoi);

  factory DoTuoi.fromJson(Map<String, dynamic> json) {
    return DoTuoi(
      idDoTuoi: json['idDoTuoi'],
      tenDoTuoi: json['tenDoTuoi'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDoTuoi': id,
      'tenDoTuoi': displayName,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
