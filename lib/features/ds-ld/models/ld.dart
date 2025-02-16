import 'package:json_annotation/json_annotation.dart';

part 'ld.g.dart';

@JsonSerializable()
class LdModel {
  @JsonKey(name: 'Idphieu')
  final int idphieu;
  @JsonKey(name: 'Maphieu')
  final String maphieu;
  @JsonKey(name: 'Ngaylap')
  final DateTime ngaylap;
  @JsonKey(name: 'Iduv')
  final int iduv;
  @JsonKey(name: 'Hoten')
  final String hoten;
  @JsonKey(name: 'Ngaysinh')
  final DateTime? ngaysinh;
  @JsonKey(name: 'IdGioitinh')
  final int idGioitinh;
  @JsonKey(name: 'SoCMND')
  final String? soCMND;
  @JsonKey(name: 'MasoBHXH')
  final String? masoBHXH;
  @JsonKey(name: 'IdDantoc')
  final int? idDantoc;
  @JsonKey(name: 'IdTongiao')
  final int? idTongiao;
  @JsonKey(name: 'MatinhHK')
  final String matinhHK;
  @JsonKey(name: 'MahuyenHK')
  final String mahuyenHK;
  @JsonKey(name: 'MaxaHK')
  final String maxaHK;
  @JsonKey(name: 'DiachiHK')
  final String? diachiHK;
  @JsonKey(name: 'MatinhTT')
  final String matinhTT;
  @JsonKey(name: 'MahuyenTT')
  final String mahuyenTT;
  @JsonKey(name: 'MaxaTT')
  final String maxaTT;
  @JsonKey(name: 'DiachiTT')
  final String? diachiTT;
  @JsonKey(name: 'Iddoituong')
  final int iddoituong;
  @JsonKey(name: 'chkTantat')
  final bool? chkTantat;
  @JsonKey(name: 'IdTantat')
  final int? idTantat;
  @JsonKey(name: 'chkHongheo')
  final bool? chkHongheo;
  @JsonKey(name: 'chkHocanngheo')
  final bool? chkHocanngheo;
  @JsonKey(name: 'Thuhoidat')
  final bool? thuhoidat;
  @JsonKey(name: 'Cocongcm')
  final bool? cocongcm;
  @JsonKey(name: 'Dantocts')
  final bool? dantocts;
  @JsonKey(name: 'IdDantocts')
  final int? idDantocts;
  @JsonKey(name: 'Idhocvan')
  final int? idhocvan;
  @JsonKey(name: 'IdBacHoc')
  final String? idBacHoc;
  @JsonKey(name: 'IdChuyennganh')
  final String? idChuyennganh;
  @JsonKey(name: 'IdNganh')
  final int? idNganh;
  @JsonKey(name: 'chkCovieclam')
  final bool? chkCovieclam;
  @JsonKey(name: 'chkThatnghiep')
  final bool? chkThatnghiep;
  @JsonKey(name: 'chkKhongthamgia')
  final bool? chkKhongthamgia;
  @JsonKey(name: 'chkDihoc')
  final bool? chkDihoc;
  @JsonKey(name: 'chkHuutri')
  final bool? chkHuutri;
  @JsonKey(name: 'chkNoitro')
  final bool? chkNoitro;
  @JsonKey(name: 'chkKhuyettat')
  final bool? chkKhuyettat;
  @JsonKey(name: 'chkKhac')
  final bool? chkKhac;
  @JsonKey(name: 'IdVithevieclam')
  final int? idVithevieclam;
  @JsonKey(name: 'Viecdanglam')
  final String viecdanglam;
  @JsonKey(name: 'IdLoaiBH')
  final int? idLoaiBH;
  @JsonKey(name: 'chkHopdongLD')
  final bool? chkHopdongLD;
  @JsonKey(name: 'IdLoaiHD')
  final String? idLoaiHD;
  @JsonKey(name: 'ThoigianHD')
  final DateTime? thoigianHD;
  @JsonKey(name: 'Noilamviec')
  final String? noilamviec;
  @JsonKey(name: 'IdLoaiHinhNoilamviec')
  final int? idLoaiHinhNoilamviec;
  @JsonKey(name: 'IdLoaihinhDN')
  final String? idLoaihinhDN;
  @JsonKey(name: 'DiachiNoilamviec')
  final String? diachiNoilamviec;
  @JsonKey(name: 'IdLoaithatnghiep')
  final int? idLoaithatnghiep;
  @JsonKey(name: 'IdTGThatnghiep')
  final int? idTGThatnghiep;
  @JsonKey(name: 'Ghichu')
  final String? ghichu;
  @JsonKey(name: 'TenNguoiViet')
  final String? tenNguoiViet;
  @JsonKey(name: 'Dienthoai')
  final String? dienthoai;
  @JsonKey(name: 'Email')
  final String? email;
  @JsonKey(name: 'DisplayOrder')
  final int displayOrder;
  @JsonKey(name: 'CreatedDate')
  final DateTime createdDate;
  @JsonKey(name: 'CreatedBy')
  final String? createdBy;
  @JsonKey(name: 'ModifiredDate')
  final DateTime modifiredDate;
  @JsonKey(name: 'ModifiredBy')
  final String? modifiredBy;
  @JsonKey(name: 'MahoGD')
  final String? mahoGD;
  @JsonKey(name: 'Status')
  final bool status;

  LdModel({
    required this.idphieu,
    required this.maphieu,
    required this.ngaylap,
    required this.iduv,
    required this.hoten,
    this.ngaysinh,
    required this.idGioitinh,
    this.soCMND,
    this.masoBHXH,
    this.idDantoc,
    this.idTongiao,
    required this.matinhHK,
    required this.mahuyenHK,
    required this.maxaHK,
    this.diachiHK,
    required this.matinhTT,
    required this.mahuyenTT,
    required this.maxaTT,
    this.diachiTT,
    required this.iddoituong,
    this.chkTantat,
    this.idTantat,
    this.chkHongheo,
    this.chkHocanngheo,
    this.thuhoidat,
    this.cocongcm,
    this.dantocts,
    this.idDantocts,
    this.idhocvan,
    this.idBacHoc,
    this.idChuyennganh,
    this.idNganh,
    this.chkCovieclam,
    this.chkThatnghiep,
    this.chkKhongthamgia,
    this.chkDihoc,
    this.chkHuutri,
    this.chkNoitro,
    this.chkKhuyettat,
    this.chkKhac,
    this.idVithevieclam,
    required this.viecdanglam,
    this.idLoaiBH,
    this.chkHopdongLD,
    this.idLoaiHD,
    this.thoigianHD,
    this.noilamviec,
    this.idLoaiHinhNoilamviec,
    this.idLoaihinhDN,
    this.diachiNoilamviec,
    this.idLoaithatnghiep,
    this.idTGThatnghiep,
    this.ghichu,
    this.tenNguoiViet,
    this.dienthoai,
    this.email,
    required this.displayOrder,
    required this.createdDate,
    this.createdBy,
    required this.modifiredDate,
    this.modifiredBy,
    this.mahoGD,
    required this.status,
  });

  factory LdModel.fromJson(Map<String, dynamic> json) =>
      _$LdModelFromJson(json);

  Map<String, dynamic> toJson() => _$LdModelToJson(this);

  LdModel copyWith({
    int? idphieu,
    String? maphieu,
    DateTime? ngaylap,
    int? iduv,
    String? hoten,
    DateTime? ngaysinh,
    int? idGioitinh,
    String? soCMND,
    String? masoBHXH,
    int? idDantoc,
    int? idTongiao,
    String? matinhHK,
    String? mahuyenHK,
    String? maxaHK,
    String? diachiHK,
    String? matinhTT,
    String? mahuyenTT,
    String? maxaTT,
    String? diachiTT,
    int? iddoituong,
    bool? chkTantat,
    int? idTantat,
    bool? chkHongheo,
    bool? chkHocanngheo,
    bool? thuhoidat,
    bool? cocongcm,
    bool? dantocts,
    int? idDantocts,
    int? idhocvan,
    String? idBacHoc,
    String? idChuyennganh,
    int? idNganh,
    bool? chkCovieclam,
    bool? chkThatnghiep,
    bool? chkKhongthamgia,
    bool? chkDihoc,
    bool? chkHuutri,
    bool? chkNoitro,
    bool? chkKhuyettat,
    bool? chkKhac,
    int? idVithevieclam,
    String? viecdanglam,
    int? idLoaiBH,
    bool? chkHopdongLD,
    String? idLoaiHD,
    DateTime? thoigianHD,
    String? noilamviec,
    int? idLoaiHinhNoilamviec,
    String? idLoaihinhDN,
    String? diachiNoilamviec,
    int? idLoaithatnghiep,
    int? idTGThatnghiep,
    String? ghichu,
    String? tenNguoiViet,
    String? dienthoai,
    String? email,
    int? displayOrder,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
    String? mahoGD,
    bool? status,
  }) {
    return LdModel(
      idphieu: idphieu ?? this.idphieu,
      maphieu: maphieu ?? this.maphieu,
      ngaylap: ngaylap ?? this.ngaylap,
      iduv: iduv ?? this.iduv,
      hoten: hoten ?? this.hoten,
      ngaysinh: ngaysinh ?? this.ngaysinh,
      idGioitinh: idGioitinh ?? this.idGioitinh,
      soCMND: soCMND ?? this.soCMND,
      masoBHXH: masoBHXH ?? this.masoBHXH,
      idDantoc: idDantoc ?? this.idDantoc,
      idTongiao: idTongiao ?? this.idTongiao,
      matinhHK: matinhHK ?? this.matinhHK,
      mahuyenHK: mahuyenHK ?? this.mahuyenHK,
      maxaHK: maxaHK ?? this.maxaHK,
      diachiHK: diachiHK ?? this.diachiHK,
      matinhTT: matinhTT ?? this.matinhTT,
      mahuyenTT: mahuyenTT ?? this.mahuyenTT,
      maxaTT: maxaTT ?? this.maxaTT,
      diachiTT: diachiTT ?? this.diachiTT,
      iddoituong: iddoituong ?? this.iddoituong,
      chkTantat: chkTantat ?? this.chkTantat,
      idTantat: idTantat ?? this.idTantat,
      chkHongheo: chkHongheo ?? this.chkHongheo,
      chkHocanngheo: chkHocanngheo ?? this.chkHocanngheo,
      thuhoidat: thuhoidat ?? this.thuhoidat,
      cocongcm: cocongcm ?? this.cocongcm,
      dantocts: dantocts ?? this.dantocts,
      idDantocts: idDantocts ?? this.idDantocts,
      idhocvan: idhocvan ?? this.idhocvan,
      idBacHoc: idBacHoc ?? this.idBacHoc,
      idChuyennganh: idChuyennganh ?? this.idChuyennganh,
      idNganh: idNganh ?? this.idNganh,
      chkCovieclam: chkCovieclam ?? this.chkCovieclam,
      chkThatnghiep: chkThatnghiep ?? this.chkThatnghiep,
      chkKhongthamgia: chkKhongthamgia ?? this.chkKhongthamgia,
      chkDihoc: chkDihoc ?? this.chkDihoc,
      chkHuutri: chkHuutri ?? this.chkHuutri,
      chkNoitro: chkNoitro ?? this.chkNoitro,
      chkKhuyettat: chkKhuyettat ?? this.chkKhuyettat,
      chkKhac: chkKhac ?? this.chkKhac,
      idVithevieclam: idVithevieclam ?? this.idVithevieclam,
      viecdanglam: viecdanglam ?? this.viecdanglam,
      idLoaiBH: idLoaiBH ?? this.idLoaiBH,
      chkHopdongLD: chkHopdongLD ?? this.chkHopdongLD,
      idLoaiHD: idLoaiHD ?? this.idLoaiHD,
      thoigianHD: thoigianHD ?? this.thoigianHD,
      noilamviec: noilamviec ?? this.noilamviec,
      idLoaiHinhNoilamviec: idLoaiHinhNoilamviec ?? this.idLoaiHinhNoilamviec,
      idLoaihinhDN: idLoaihinhDN ?? this.idLoaihinhDN,
      diachiNoilamviec: diachiNoilamviec ?? this.diachiNoilamviec,
      idLoaithatnghiep: idLoaithatnghiep ?? this.idLoaithatnghiep,
      idTGThatnghiep: idTGThatnghiep ?? this.idTGThatnghiep,
      ghichu: ghichu ?? this.ghichu,
      tenNguoiViet: tenNguoiViet ?? this.tenNguoiViet,
      dienthoai: dienthoai ?? this.dienthoai,
      email: email ?? this.email,
      displayOrder: displayOrder ?? this.displayOrder,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      modifiredDate: modifiredDate ?? this.modifiredDate,
      modifiredBy: modifiredBy ?? this.modifiredBy,
      mahoGD: mahoGD ?? this.mahoGD,
      status: status ?? this.status,
    );
  }
}
