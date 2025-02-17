import 'package:json_annotation/json_annotation.dart';

part 'ntv_model.g.dart';

@JsonSerializable()
class Ntv {
  final int? id;
  final String uvUsername;
  final String? uvPassword;
  final String? uvHoten;
  final String? uvEmail;
  final String? maHoSo;
  final int? idDanToc;
  final String? cvMongMuon;
  final String? documentPath;
  final String? imagePath;
  final String? uvDiachichitiet;
  final String? uvDienthoai;
  final String? uvSoCMND;
  final DateTime? uvNgaycap;
  final String? uvNoicap;
  final int? uvGioitinh;
  final String? uvChieucao;
  final String? uvCannang;
  final int? uvDoituongchinhsach;
  final int? uvTinhtrangtantat;
  @JsonKey(defaultValue: false)
  final bool uvHonnhan;
  final DateTime? uvNgaysinh;
  final String? uvcmCongviechientai;
  final int? uvnvNganhnghe;
  final int? uvnvVitrimongmuon;
  final int? uvnvThoigian;
  final String? uvnvNoilamviec;
  final int? idMucluong;
  final int? uvnvTienluong;
  final int? uvnvHinhthuccongty;
  final String? uvGhichu;
  final int? uvcmTrinhdo;
  final String? uvcmBangcap;
  final String? uvcmKynang;
  final String? uvcmTrinhdongoaingu;
  final String? uvcmTrinhdotinhoc;
  @JsonKey(defaultValue: 0)
  final int uvcmKinhnghiem;
  @JsonKey(defaultValue: 0)
  final int uvSolanxem;
  @JsonKey(defaultValue: 0)
  final int interview;
  @JsonKey(defaultValue: 0)
  final int interviewed;
  @JsonKey(defaultValue: false)
  final bool uvDuyet;
  @JsonKey(defaultValue: false)
  final bool uvHienthi;
  @JsonKey(defaultValue: false)
  final bool uvhtTelephone;
  @JsonKey(defaultValue: false)
  final bool uvhtEmail;
  @JsonKey(defaultValue: false)
  final bool uvhtAddress;
  @JsonKey(defaultValue: 'system')
  final String createdBy;
  @JsonKey(defaultValue: 'system')
  final String modifiredBy;
  @JsonKey(defaultValue: false)
  final bool newsletterSubscription;
  @JsonKey(defaultValue: false)
  final bool jobsletterSubscription;
  @JsonKey(defaultValue: false)
  final bool coBHTN;
  final String? soNhaDuong;
  final int? idThanhPho;
  final String? idTinh;
  final String? idHuyen;
  final String? idXa;
  final int? idTv;
  final String? mahoGD;
  final String? fileCV;
  final int? displayOrder;
  final DateTime? ngayduyet;
  final String? idNguonThuThap;
  final String? idBacHoc;
  final String? diachilienhe;
  final String? avatarUrl;
  final DateTime? createdDate;
  final DateTime? modifiredDate;

  Ntv({
    this.id,
    required this.uvUsername,
    this.uvPassword,
    this.uvHoten,
    this.uvEmail,
    this.maHoSo,
    this.idDanToc,
    this.cvMongMuon,
    this.documentPath,
    this.imagePath,
    this.uvDiachichitiet,
    this.uvDienthoai,
    this.uvSoCMND,
    this.uvNgaycap,
    this.uvNoicap,
    this.uvGioitinh,
    this.uvChieucao,
    this.uvCannang,
    this.uvDoituongchinhsach,
    this.uvTinhtrangtantat,
    this.uvHonnhan = false,
    this.uvNgaysinh,
    this.uvcmCongviechientai,
    this.uvnvNganhnghe,
    this.uvnvVitrimongmuon,
    this.uvnvThoigian,
    this.uvnvNoilamviec,
    this.idMucluong,
    this.uvnvTienluong,
    this.uvnvHinhthuccongty,
    this.uvGhichu,
    this.uvcmTrinhdo,
    this.uvcmBangcap,
    this.uvcmKynang,
    this.uvcmTrinhdongoaingu,
    this.uvcmTrinhdotinhoc,
    this.uvcmKinhnghiem = 0,
    this.uvSolanxem = 0,
    this.interview = 0,
    this.interviewed = 0,
    this.uvDuyet = false,
    this.uvHienthi = false,
    this.uvhtTelephone = false,
    this.uvhtEmail = false,
    this.uvhtAddress = false,
    this.createdBy = 'system',
    this.modifiredBy = 'system',
    this.newsletterSubscription = false,
    this.jobsletterSubscription = false,
    this.coBHTN = false,
    this.soNhaDuong,
    this.idThanhPho,
    this.idTinh,
    this.idHuyen,
    this.idXa,
    this.idTv,
    this.mahoGD,
    this.fileCV,
    this.displayOrder,
    this.ngayduyet,
    this.idNguonThuThap,
    this.idBacHoc,
    this.diachilienhe,
    this.avatarUrl,
    this.createdDate,
    this.modifiredDate,
  });

  /// Factory to parse JSON
  factory Ntv.fromJson(Map<String, dynamic> json) => _$NtvFromJson(json);

  /// Convert object to JSON
  Map<String, dynamic> toJson() => _$NtvToJson(this);
}
