import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class KieuChapNoiModel extends GenericPickerItem {
  int? displayOrder;
  String? createdBy;
  String? createdDate;
  String? modifiedBy;
  String? modifiredDate;
  bool? status;

  KieuChapNoiModel({
    required String idKieuChapNoi,
    required String tenKieuChapNoi,
    this.displayOrder,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiredDate,
    this.status,
  }) : super(id: idKieuChapNoi, displayName: tenKieuChapNoi);

  factory KieuChapNoiModel.fromJson(Map<String, dynamic> json) {
    return KieuChapNoiModel(
      idKieuChapNoi: json['idKieuChapNoi'],
      tenKieuChapNoi: json['tenKieuChapNoi'],
      displayOrder: json['displayOrder'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      modifiedBy: json['modifiedBy'],
      modifiredDate: json['modifiredDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idKieuChapNoi': id,
      'tenKieuChapNoi': displayName,
      'displayOrder': displayOrder,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'modifiedBy': modifiedBy,
      'modifiredDate': modifiredDate,
      'status': status,
    };
  }
}
