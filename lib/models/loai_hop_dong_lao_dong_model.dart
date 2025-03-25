import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class LoaiHopDongLaoDong extends GenericPickerItem {
  String? idhinhthuclamviec;
  int? displayOrder;
  bool? status;

  LoaiHopDongLaoDong({
    required super.id,
    required String ten,
    this.idhinhthuclamviec,
    this.displayOrder,
    this.status,
  }) : super(displayName: ten);

  factory LoaiHopDongLaoDong.fromJson(Map<String, dynamic> json) {
    return LoaiHopDongLaoDong(
      id: json['id'],
      ten: json['ten'],
      idhinhthuclamviec: json['idhinhthuclamviec'],
      displayOrder: json['displayOrder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': displayName,
      'idhinhthuclamviec': idhinhthuclamviec,
      'displayOrder': displayOrder,
      'status': status,
    };
  }
}
