import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class TrinhDoChuyenMon extends GenericPickerItem {
  String? idNhom;
  int? ordinalNumbers;
  bool? status;

  TrinhDoChuyenMon({
    required super.id,
    required String name,
    this.idNhom,
    this.ordinalNumbers,
    this.status,
  }) : super(displayName: name);

  factory TrinhDoChuyenMon.fromJson(Map<String, dynamic> json) {
    return TrinhDoChuyenMon(
      id: json['id'],
      name: json['name'],
      idNhom: json['idNhom'],
      ordinalNumbers: json['ordinalNumbers'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': displayName,
      'idNhom': idNhom,
      'ordinalNumbers': ordinalNumbers,
      'status': status,
    };
  }
}
