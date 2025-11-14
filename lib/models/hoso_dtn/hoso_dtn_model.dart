import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/core/utils/int_to_bool_converter.dart';

part 'hoso_dtn_model.freezed.dart';
part 'hoso_dtn_model.g.dart';

@freezed
class HosoDTN with _$HosoDTN {
  const factory HosoDTN({
    String? id,
    int? idloai,
    DateTime? dkdtnNgay,
    String? dkdtnUsername,
    String? dkdtnEmail,
    String? dkdtnPassword,
    String? dkdtnHoten,
    String? imagePath,
    DateTime? dkdtnNgaysinh,
    String? dkdtnChuyenmon,
    String? dkdtnDienthoai,
    int? dkdtnDantoc,
    int? dkdtnTongiao,
    String? dkdtnHokhauthuongtru,
    int? dkdtndmNghenganhan,
    int? dkdtndmNghesocap,
    String? dkdtnGhichu,
    @IntToBoolConverter() bool? dkdtnhtTelephone,
    @IntToBoolConverter() bool? dkdtnhtEmail,
    @IntToBoolConverter() bool? dkdtnhtAddress,
    String? soNhaDuong,
    String? maTinh,
    String? maHuyen,
    String? maXa,
    int? idDaoTao,
    String? nguyenQuan,
    String? idTdNgoaiNgu,
    String? chieuCao,
    String? canNang,
    String? matTrai,
    String? matPhai,
    String? muMau,
    String? hoTenCha,
    String? hoTenMe,
    String? diaChiBaoTin,
    String? dienThoaiBaoTin,
    String? tinNhanBaoTin,
    String? soHoChieu,
    @IntToBoolConverter() bool? docThan,
    @IntToBoolConverter() bool? daCoGiaDinh,
    @IntToBoolConverter() bool? daLyDi,
    int? soCon,
    String? daLamViecONuocNgoai,
    @IntToBoolConverter() bool? coBhtn,
    String? idtv,
    int? dkStatus,
    String? dkngonngu,
    @IntToBoolConverter() bool? duyetdangky,
    int? dkdtndmDoituongchinhsach,
    int? dkdtndmTruong,
    int? dkdtnGioitinh,
    int? dkdtnDuyet,
    @IntToBoolConverter() bool? idTrangThaiTrungTuyen,
    int? dkdtndmTrinhdohocvanDtn,
    int? dkdtndmNghedaotao,
    int? dkdtndmNganhcaodang,
    int? dkdtndmNganhtrungcap,
  }) = _HosoDTN;

  factory HosoDTN.fromJson(Map<String, dynamic> json) =>
      _$HosoDTNFromJson(json);
}
