import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapnoi_model.freezed.dart';
part 'chapnoi_model.g.dart';

@freezed
class ChapNoiModel with _$ChapNoiModel {
  const factory ChapNoiModel({
     int? id,
    required String idKieuChapNoi,
    required String idUngVien,
    required String idDoanhNghiep,
    required String idTuyenDung,
    required String ngayMuonHs,
     String? ngayTraHs,
    String? ghiChu,
     int? idKetQua,
     int? displayOrder,
    String? createdDate,
    String? createdBy,
    String? modifiredDate,
    String? modifiredBy,
    String? tenKieuChapNoi,
    String? tenUngvien,
    String? sdtUngvien,
    String? tenDoanhNghiep,
    String? tenTuyendung,
    String? tenKetqua,
  }) = _ChapNoiModel;

  factory ChapNoiModel.fromJson(Map<String, dynamic> json) =>
      _$ChapNoiModelFromJson(json);
}
