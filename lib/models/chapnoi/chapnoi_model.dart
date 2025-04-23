import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapnoi_model.freezed.dart';
part 'chapnoi_model.g.dart';

@freezed
class ChapNoiModel with _$ChapNoiModel {
  const factory ChapNoiModel({
    required String idKieuChapNoi,
    required String idUngVien,
    required String idDoanhNghiep,
    required String idTuyenDung,
    required String ngayMuonHs,
    required String ngayTraHs,
    required String ghiChu,
    @Default(0) int idKetQua,
    @Default(0) int displayOrder,
  }) = _ChapNoiModel;

  factory ChapNoiModel.fromJson(Map<String, dynamic> json) =>
      _$ChapNoiModelFromJson(json);
}
