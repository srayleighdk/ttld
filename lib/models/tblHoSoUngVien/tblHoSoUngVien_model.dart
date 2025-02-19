import 'package:freezed_annotation/freezed_annotation.dart';

part 'tblHoSoUngVien_model.freezed.dart';
part 'tblHoSoUngVien_model.g.dart';

@freezed
class TblHoSoUngVienModel with _$TblHoSoUngVienModel {
  const factory TblHoSoUngVienModel({
    required int id,
    required String name,
  }) = _TblHoSoUngVienModel;

  factory TblHoSoUngVienModel.fromJson(Map<String, dynamic> json) =>
      _$TblHoSoUngVienModelFromJson(json);
}
