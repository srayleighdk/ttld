import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class HoSoUngVienPickerItem extends GenericPickerItem {
  final TblHoSoUngVienModel hoSoUngVien;

  HoSoUngVienPickerItem(this.hoSoUngVien)
      : super(
          id: hoSoUngVien.id,
          displayName: hoSoUngVien.uvHoten ?? hoSoUngVien.uvUsername ?? '',
        );
}

class TuyenDungPickerItem extends GenericPickerItem {
  final NTDTuyenDung tuyenDung;

  TuyenDungPickerItem(this.tuyenDung)
      : super(
          id: tuyenDung.idTuyenDung ?? '',
          displayName: tuyenDung.tdTieude ?? '',
        );
}
