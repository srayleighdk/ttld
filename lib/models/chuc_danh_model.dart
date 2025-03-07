import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class ChucDanhModel extends GenericPickerItem {
  int? displayOrder;
  int? idLoai;
  bool? status;

  ChucDanhModel({
    required int id,
    required String name,
    this.displayOrder,
    this.idLoai,
    this.status,
  }) : super(id: id, displayName: name);

  factory ChucDanhModel.fromJson(Map<String, dynamic> json) {
    return ChucDanhModel(
      id: json['id'],
      name: json['name'],
      displayOrder: json['displayOrder'],
      idLoai: json['idLoai'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = displayName;
    data['displayOrder'] = displayOrder;
    data['idLoai'] = idLoai;
    data['status'] = status;
    return data;
  }
}
