import 'package:json_annotation/json_annotation.dart';

part 'dn_dk_pgd_model.g.dart';

@JsonSerializable()
class DnDkPgd {
  String? id;
  String? idDoanhnghiep;
  String? dksgdUsername;
  String? dksgdEmail;
  String? dksgdTen;
  String? dksgdTentat;
  String? maHoSo;
  dynamic dksgdNguoilienhe;
  dynamic dksgdWebsite;
  int? dksgdSolaodong;
  dynamic dksgdNganhnghekinhdoanh;
  dynamic dksgdDienthoai;
  dynamic dksgdFax;
  dynamic dksgdDiachichitiet;
  dynamic dksgddmHinhthucthamgia;
  dynamic dksgdNganhnghe;
  dynamic dksgdGhichu;
  dynamic dksgdSolanxem;
  bool? dksgdHienthi;
  bool? dksgdhtNlh;
  bool? dksgdhtTelephone;
  bool? dksgdhtWeb;
  bool? dksgdhtFax;
  bool? dksgdhtEmail;
  bool? dksgdhtAddress;
  bool? dksgdhtName;
  dynamic dksgdDuyet;
  dynamic dksgddmHinhthucdoanhnghiep;
  dynamic dksgddmPhiengiaodichlan;
  dynamic dksgddmPhiengiaodichlanTen;
  dynamic dksgddmHinhthucdoanhnghiepTen;
  DateTime? createdDate;
  dynamic createdBy;
  DateTime? modifiredDate;
  dynamic modifiredBy;

  DnDkPgd({
    this.id,
    this.idDoanhnghiep,
    this.dksgdUsername,
    this.dksgdEmail,
    this.dksgdTen,
    this.dksgdTentat,
    this.maHoSo,
    this.dksgdNguoilienhe,
    this.dksgdWebsite,
    this.dksgdSolaodong,
    this.dksgdNganhnghekinhdoanh,
    this.dksgdDienthoai,
    this.dksgdFax,
    this.dksgdDiachichitiet,
    this.dksgddmHinhthucthamgia,
    this.dksgdNganhnghe,
    this.dksgdGhichu,
    this.dksgdSolanxem,
    this.dksgdHienthi,
    this.dksgdhtNlh,
    this.dksgdhtTelephone,
    this.dksgdhtWeb,
    this.dksgdhtFax,
    this.dksgdhtEmail,
    this.dksgdhtAddress,
    this.dksgdhtName,
    this.dksgdDuyet,
    this.dksgddmHinhthucdoanhnghiep,
    this.dksgddmPhiengiaodichlan,
    this.dksgddmPhiengiaodichlanTen,
    this.dksgddmHinhthucdoanhnghiepTen,
    this.createdDate,
    this.createdBy,
    this.modifiredDate,
    this.modifiredBy,
  });

  factory DnDkPgd.fromJson(Map<String, dynamic> json) =>
      _$DnDkPgdFromJson(json);

  Map<String, dynamic> toJson() => _$DnDkPgdToJson(this);
}
