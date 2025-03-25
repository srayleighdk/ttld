import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class NganhNgheBacHoc extends GenericPickerItem {
  String? idNhom;
  int? ordinalNumbers;
  bool? status;

  NganhNgheBacHoc({
    required super.id,
    required String name,
    this.idNhom,
    this.ordinalNumbers,
    this.status,
  }) : super(displayName: name);

  factory NganhNgheBacHoc.fromJson(Map<String, dynamic> json) {
    return NganhNgheBacHoc(
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
