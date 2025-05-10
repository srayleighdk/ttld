import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';
import 'tblNhaTuyenDung_model.dart';

class NTDPickerItem extends GenericPickerItem {
  final Ntd ntd;

  NTDPickerItem({
    required this.ntd,
  }) : super(
          id: ntd.idDoanhNghiep ?? '',
          displayName: ntd.ntdTen ?? '',
        );

  factory NTDPickerItem.fromNtd(Ntd ntd) {
    return NTDPickerItem(ntd: ntd);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'ntd': ntd.toJson(),
    };
  }
} 