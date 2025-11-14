class HosoXKLDModel {
  String? id;

  // Required fields
  String? dkxkldNgay;
  String? dkxkldUsername;
  int? dkxklddmTrinhdohocvan;
  int? dkxkldGioitinh;
  bool? dkxkldKhanangtaichinh;
  int? dkxklddmNgoaingudaotao;
  bool? dkxkldDuyet;
  bool? dkxkldHochieu;
  bool? dkxkldHonnhan;
  bool? dkxkldIdTths;
  bool? dkxkldIdKqpv;
  int? dkxklddmDoituongchinhsach;
  int? dkxklddmQuocgia;

  // Personal information
  String? imagePath;
  String? dkxkldEmail;
  String? dkxkldPassword;
  String? dkxkldHoten;
  String? dkxkldNgaysinh;
  String? dkxkldSohochieu;
  String? dkxkldDienthoai;
  String? dkxkldSoCmnd;
  String? dkxkldNgaycap;
  String? dkxkldNoicap;
  String? dkxkldDantoc;
  String? dkxkldTongiao;

  // Physical information
  String? dkxkldChieucao;
  String? dkxkldCannang;

  // Address information
  String? dkxkldNguyenquan;
  String? dkxkldHokhauthuongtru;
  String? dkxkldDiachitamtru;
  String? thonBuon;
  String? xaPhuong;
  String? huyenThiThanhPho;
  String? tinh;

  // Education & Training
  String? dkxkldChuyenmon;
  String? dkxkldBacdaotao;
  String? dkxkldDangdoan;
  String? dkxkldNganhnghemongmuon;
  String? dkxkldNndaduocdaotao;

  // Job preferences
  String? idNganhKinhTe;
  int? vitrimongmuon;
  String? viecdanglam;

  // Notes & Status
  String? dkxkldGhichu;
  int? dkxkldSolanxem;

  // Notification preferences
  bool? dkxkldhtTelephone;
  bool? dkxkldhtEmail;
  bool? dkxkldhtAddress;

  // Export status
  bool? daXuatCanh;
  String? ngayXuatCanh;
  bool? daXem;

  // Business related
  String? idDoanhNghiep;
  String? ngayGioiThieu;
  String? nguoiBaoLanh;
  String? dienthoailienhe;
  bool? datSoTuyen;

  // Return information
  bool? venuoc;
  String? ngayvenuoc;
  String? lydovenuoc;

  // Other
  int? displayOrder;

  HosoXKLDModel({
    this.id,
    this.dkxkldNgay,
    this.dkxkldUsername,
    this.dkxklddmTrinhdohocvan,
    this.dkxkldGioitinh,
    this.dkxkldKhanangtaichinh,
    this.dkxklddmNgoaingudaotao,
    this.dkxkldDuyet,
    this.dkxkldHochieu,
    this.dkxkldHonnhan,
    this.dkxkldIdTths,
    this.dkxkldIdKqpv,
    this.dkxklddmDoituongchinhsach,
    this.dkxklddmQuocgia,
    this.imagePath,
    this.dkxkldEmail,
    this.dkxkldPassword,
    this.dkxkldHoten,
    this.dkxkldNgaysinh,
    this.dkxkldSohochieu,
    this.dkxkldDienthoai,
    this.dkxkldSoCmnd,
    this.dkxkldNgaycap,
    this.dkxkldNoicap,
    this.dkxkldDantoc,
    this.dkxkldTongiao,
    this.dkxkldChieucao,
    this.dkxkldCannang,
    this.dkxkldNguyenquan,
    this.dkxkldHokhauthuongtru,
    this.dkxkldDiachitamtru,
    this.thonBuon,
    this.xaPhuong,
    this.huyenThiThanhPho,
    this.tinh,
    this.dkxkldChuyenmon,
    this.dkxkldBacdaotao,
    this.dkxkldDangdoan,
    this.dkxkldNganhnghemongmuon,
    this.dkxkldNndaduocdaotao,
    this.idNganhKinhTe,
    this.vitrimongmuon,
    this.viecdanglam,
    this.dkxkldGhichu,
    this.dkxkldSolanxem,
    this.dkxkldhtTelephone,
    this.dkxkldhtEmail,
    this.dkxkldhtAddress,
    this.daXuatCanh,
    this.ngayXuatCanh,
    this.daXem,
    this.idDoanhNghiep,
    this.ngayGioiThieu,
    this.nguoiBaoLanh,
    this.dienthoailienhe,
    this.datSoTuyen,
    this.venuoc,
    this.ngayvenuoc,
    this.lydovenuoc,
    this.displayOrder,
  });

  factory HosoXKLDModel.fromJson(Map<String, dynamic> json) {
    return HosoXKLDModel(
      id: json['id'] as String?,
      dkxkldNgay: json['dkxkldNgay'] as String?,
      dkxkldUsername: json['dkxkldUsername'] as String?,
      dkxklddmTrinhdohocvan: json['dkxklddmTrinhdohocvan'] as int?,
      dkxkldGioitinh: json['dkxkldGioitinh'] as int?,
      dkxkldKhanangtaichinh: json['dkxkldKhanangtaichinh'] as bool?,
      dkxklddmNgoaingudaotao: json['dkxklddmNgoaingudaotao'] as int?,
      dkxkldDuyet: json['dkxkldDuyet'] as bool?,
      dkxkldHochieu: json['dkxkldHochieu'] as bool?,
      dkxkldHonnhan: json['dkxkldHonnhan'] as bool?,
      dkxkldIdTths: json['dkxkldIdTths'] as bool?,
      dkxkldIdKqpv: json['dkxkldIdKqpv'] as bool?,
      dkxklddmDoituongchinhsach: json['dkxklddmDoituongchinhsach'] as int?,
      dkxklddmQuocgia: json['dkxklddmQuocgia'] as int?,
      imagePath: json['imagePath'] as String?,
      dkxkldEmail: json['dkxkldEmail'] as String?,
      dkxkldPassword: json['dkxkldPassword'] as String?,
      dkxkldHoten: json['dkxkldHoten'] as String?,
      dkxkldNgaysinh: json['dkxkldNgaysinh'] as String?,
      dkxkldSohochieu: json['dkxkldSohochieu'] as String?,
      dkxkldDienthoai: json['dkxkldDienthoai'] as String?,
      dkxkldSoCmnd: json['dkxkldSoCmnd'] as String?,
      dkxkldNgaycap: json['dkxkldNgaycap'] as String?,
      dkxkldNoicap: json['dkxkldNoicap'] as String?,
      dkxkldDantoc: json['dkxkldDantoc'] as String?,
      dkxkldTongiao: json['dkxkldTongiao'] as String?,
      dkxkldChieucao: json['dkxkldChieucao'] as String?,
      dkxkldCannang: json['dkxkldCannang'] as String?,
      dkxkldNguyenquan: json['dkxkldNguyenquan'] as String?,
      dkxkldHokhauthuongtru: json['dkxkldHokhauthuongtru'] as String?,
      dkxkldDiachitamtru: json['dkxkldDiachitamtru'] as String?,
      thonBuon: json['thonBuon'] as String?,
      xaPhuong: json['xaPhuong'] as String?,
      huyenThiThanhPho: json['huyenThiThanhPho'] as String?,
      tinh: json['tinh'] as String?,
      dkxkldChuyenmon: json['dkxkldChuyenmon'] as String?,
      dkxkldBacdaotao: json['dkxkldBacdaotao'] as String?,
      dkxkldDangdoan: json['dkxkldDangdoan'] as String?,
      dkxkldNganhnghemongmuon: json['dkxkldNganhnghemongmuon'] as String?,
      dkxkldNndaduocdaotao: json['dkxkldNndaduocdaotao'] as String?,
      idNganhKinhTe: json['idNganhKinhTe'] as String?,
      vitrimongmuon: json['vitrimongmuon'] as int?,
      viecdanglam: json['viecdanglam'] as String?,
      dkxkldGhichu: json['dkxkldGhichu'] as String?,
      dkxkldSolanxem: json['dkxkldSolanxem'] as int?,
      dkxkldhtTelephone: json['dkxkldhtTelephone'] as bool?,
      dkxkldhtEmail: json['dkxkldhtEmail'] as bool?,
      dkxkldhtAddress: json['dkxkldhtAddress'] as bool?,
      daXuatCanh: json['daXuatCanh'] as bool?,
      ngayXuatCanh: json['ngayXuatCanh'] as String?,
      daXem: json['daXem'] as bool?,
      idDoanhNghiep: json['idDoanhNghiep'] as String?,
      ngayGioiThieu: json['ngayGioiThieu'] as String?,
      nguoiBaoLanh: json['nguoiBaoLanh'] as String?,
      dienthoailienhe: json['dienthoailienhe'] as String?,
      datSoTuyen: json['datSoTuyen'] as bool?,
      venuoc: json['venuoc'] as bool?,
      ngayvenuoc: json['ngayvenuoc'] as String?,
      lydovenuoc: json['lydovenuoc'] as String?,
      displayOrder: json['displayOrder'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (dkxkldNgay != null) 'dkxkldNgay': dkxkldNgay,
      if (dkxkldUsername != null) 'dkxkldUsername': dkxkldUsername,
      if (dkxklddmTrinhdohocvan != null)
        'dkxklddmTrinhdohocvan': dkxklddmTrinhdohocvan,
      if (dkxkldGioitinh != null) 'dkxkldGioitinh': dkxkldGioitinh,
      if (dkxkldKhanangtaichinh != null)
        'dkxkldKhanangtaichinh': dkxkldKhanangtaichinh,
      if (dkxklddmNgoaingudaotao != null)
        'dkxklddmNgoaingudaotao': dkxklddmNgoaingudaotao,
      if (dkxkldDuyet != null) 'dkxkldDuyet': dkxkldDuyet,
      if (dkxkldHochieu != null) 'dkxkldHochieu': dkxkldHochieu,
      if (dkxkldHonnhan != null) 'dkxkldHonnhan': dkxkldHonnhan,
      if (dkxkldIdTths != null) 'dkxkldIdTths': dkxkldIdTths,
      if (dkxkldIdKqpv != null) 'dkxkldIdKqpv': dkxkldIdKqpv,
      if (dkxklddmDoituongchinhsach != null)
        'dkxklddmDoituongchinhsach': dkxklddmDoituongchinhsach,
      if (dkxklddmQuocgia != null) 'dkxklddmQuocgia': dkxklddmQuocgia,
      if (imagePath != null) 'imagePath': imagePath,
      if (dkxkldEmail != null) 'dkxkldEmail': dkxkldEmail,
      if (dkxkldPassword != null) 'dkxkldPassword': dkxkldPassword,
      if (dkxkldHoten != null) 'dkxkldHoten': dkxkldHoten,
      if (dkxkldNgaysinh != null) 'dkxkldNgaysinh': dkxkldNgaysinh,
      if (dkxkldSohochieu != null) 'dkxkldSohochieu': dkxkldSohochieu,
      if (dkxkldDienthoai != null) 'dkxkldDienthoai': dkxkldDienthoai,
      if (dkxkldSoCmnd != null) 'dkxkldSoCmnd': dkxkldSoCmnd,
      if (dkxkldNgaycap != null) 'dkxkldNgaycap': dkxkldNgaycap,
      if (dkxkldNoicap != null) 'dkxkldNoicap': dkxkldNoicap,
      if (dkxkldDantoc != null) 'dkxkldDantoc': dkxkldDantoc,
      if (dkxkldTongiao != null) 'dkxkldTongiao': dkxkldTongiao,
      if (dkxkldChieucao != null) 'dkxkldChieucao': dkxkldChieucao,
      if (dkxkldCannang != null) 'dkxkldCannang': dkxkldCannang,
      if (dkxkldNguyenquan != null) 'dkxkldNguyenquan': dkxkldNguyenquan,
      if (dkxkldHokhauthuongtru != null)
        'dkxkldHokhauthuongtru': dkxkldHokhauthuongtru,
      if (dkxkldDiachitamtru != null)
        'dkxkldDiachitamtru': dkxkldDiachitamtru,
      if (thonBuon != null) 'thonBuon': thonBuon,
      if (xaPhuong != null) 'xaPhuong': xaPhuong,
      if (huyenThiThanhPho != null) 'huyenThiThanhPho': huyenThiThanhPho,
      if (tinh != null) 'tinh': tinh,
      if (dkxkldChuyenmon != null) 'dkxkldChuyenmon': dkxkldChuyenmon,
      if (dkxkldBacdaotao != null) 'dkxkldBacdaotao': dkxkldBacdaotao,
      if (dkxkldDangdoan != null) 'dkxkldDangdoan': dkxkldDangdoan,
      if (dkxkldNganhnghemongmuon != null)
        'dkxkldNganhnghemongmuon': dkxkldNganhnghemongmuon,
      if (dkxkldNndaduocdaotao != null)
        'dkxkldNndaduocdaotao': dkxkldNndaduocdaotao,
      if (idNganhKinhTe != null) 'idNganhKinhTe': idNganhKinhTe,
      if (vitrimongmuon != null) 'vitrimongmuon': vitrimongmuon,
      if (viecdanglam != null) 'viecdanglam': viecdanglam,
      if (dkxkldGhichu != null) 'dkxkldGhichu': dkxkldGhichu,
      if (dkxkldSolanxem != null) 'dkxkldSolanxem': dkxkldSolanxem,
      if (dkxkldhtTelephone != null) 'dkxkldhtTelephone': dkxkldhtTelephone,
      if (dkxkldhtEmail != null) 'dkxkldhtEmail': dkxkldhtEmail,
      if (dkxkldhtAddress != null) 'dkxkldhtAddress': dkxkldhtAddress,
      if (daXuatCanh != null) 'daXuatCanh': daXuatCanh,
      if (ngayXuatCanh != null) 'ngayXuatCanh': ngayXuatCanh,
      if (daXem != null) 'daXem': daXem,
      if (idDoanhNghiep != null) 'idDoanhNghiep': idDoanhNghiep,
      if (ngayGioiThieu != null) 'ngayGioiThieu': ngayGioiThieu,
      if (nguoiBaoLanh != null) 'nguoiBaoLanh': nguoiBaoLanh,
      if (dienthoailienhe != null) 'dienthoailienhe': dienthoailienhe,
      if (datSoTuyen != null) 'datSoTuyen': datSoTuyen,
      if (venuoc != null) 'venuoc': venuoc,
      if (ngayvenuoc != null) 'ngayvenuoc': ngayvenuoc,
      if (lydovenuoc != null) 'lydovenuoc': lydovenuoc,
      if (displayOrder != null) 'displayOrder': displayOrder,
    };
  }

  HosoXKLDModel copyWith({
    String? id,
    String? dkxkldNgay,
    String? dkxkldUsername,
    int? dkxklddmTrinhdohocvan,
    int? dkxkldGioitinh,
    bool? dkxkldKhanangtaichinh,
    int? dkxklddmNgoaingudaotao,
    bool? dkxkldDuyet,
    bool? dkxkldHochieu,
    bool? dkxkldHonnhan,
    bool? dkxkldIdTths,
    bool? dkxkldIdKqpv,
    int? dkxklddmDoituongchinhsach,
    int? dkxklddmQuocgia,
    String? imagePath,
    String? dkxkldEmail,
    String? dkxkldPassword,
    String? dkxkldHoten,
    String? dkxkldNgaysinh,
    String? dkxkldSohochieu,
    String? dkxkldDienthoai,
    String? dkxkldSoCmnd,
    String? dkxkldNgaycap,
    String? dkxkldNoicap,
    String? dkxkldDantoc,
    String? dkxkldTongiao,
    String? dkxkldChieucao,
    String? dkxkldCannang,
    String? dkxkldNguyenquan,
    String? dkxkldHokhauthuongtru,
    String? dkxkldDiachitamtru,
    String? thonBuon,
    String? xaPhuong,
    String? huyenThiThanhPho,
    String? tinh,
    String? dkxkldChuyenmon,
    String? dkxkldBacdaotao,
    String? dkxkldDangdoan,
    String? dkxkldNganhnghemongmuon,
    String? dkxkldNndaduocdaotao,
    String? idNganhKinhTe,
    int? vitrimongmuon,
    String? viecdanglam,
    String? dkxkldGhichu,
    int? dkxkldSolanxem,
    bool? dkxkldhtTelephone,
    bool? dkxkldhtEmail,
    bool? dkxkldhtAddress,
    bool? daXuatCanh,
    String? ngayXuatCanh,
    bool? daXem,
    String? idDoanhNghiep,
    String? ngayGioiThieu,
    String? nguoiBaoLanh,
    String? dienthoailienhe,
    bool? datSoTuyen,
    bool? venuoc,
    String? ngayvenuoc,
    String? lydovenuoc,
    int? displayOrder,
  }) {
    return HosoXKLDModel(
      id: id ?? this.id,
      dkxkldNgay: dkxkldNgay ?? this.dkxkldNgay,
      dkxkldUsername: dkxkldUsername ?? this.dkxkldUsername,
      dkxklddmTrinhdohocvan:
          dkxklddmTrinhdohocvan ?? this.dkxklddmTrinhdohocvan,
      dkxkldGioitinh: dkxkldGioitinh ?? this.dkxkldGioitinh,
      dkxkldKhanangtaichinh:
          dkxkldKhanangtaichinh ?? this.dkxkldKhanangtaichinh,
      dkxklddmNgoaingudaotao:
          dkxklddmNgoaingudaotao ?? this.dkxklddmNgoaingudaotao,
      dkxkldDuyet: dkxkldDuyet ?? this.dkxkldDuyet,
      dkxkldHochieu: dkxkldHochieu ?? this.dkxkldHochieu,
      dkxkldHonnhan: dkxkldHonnhan ?? this.dkxkldHonnhan,
      dkxkldIdTths: dkxkldIdTths ?? this.dkxkldIdTths,
      dkxkldIdKqpv: dkxkldIdKqpv ?? this.dkxkldIdKqpv,
      dkxklddmDoituongchinhsach:
          dkxklddmDoituongchinhsach ?? this.dkxklddmDoituongchinhsach,
      dkxklddmQuocgia: dkxklddmQuocgia ?? this.dkxklddmQuocgia,
      imagePath: imagePath ?? this.imagePath,
      dkxkldEmail: dkxkldEmail ?? this.dkxkldEmail,
      dkxkldPassword: dkxkldPassword ?? this.dkxkldPassword,
      dkxkldHoten: dkxkldHoten ?? this.dkxkldHoten,
      dkxkldNgaysinh: dkxkldNgaysinh ?? this.dkxkldNgaysinh,
      dkxkldSohochieu: dkxkldSohochieu ?? this.dkxkldSohochieu,
      dkxkldDienthoai: dkxkldDienthoai ?? this.dkxkldDienthoai,
      dkxkldSoCmnd: dkxkldSoCmnd ?? this.dkxkldSoCmnd,
      dkxkldNgaycap: dkxkldNgaycap ?? this.dkxkldNgaycap,
      dkxkldNoicap: dkxkldNoicap ?? this.dkxkldNoicap,
      dkxkldDantoc: dkxkldDantoc ?? this.dkxkldDantoc,
      dkxkldTongiao: dkxkldTongiao ?? this.dkxkldTongiao,
      dkxkldChieucao: dkxkldChieucao ?? this.dkxkldChieucao,
      dkxkldCannang: dkxkldCannang ?? this.dkxkldCannang,
      dkxkldNguyenquan: dkxkldNguyenquan ?? this.dkxkldNguyenquan,
      dkxkldHokhauthuongtru:
          dkxkldHokhauthuongtru ?? this.dkxkldHokhauthuongtru,
      dkxkldDiachitamtru: dkxkldDiachitamtru ?? this.dkxkldDiachitamtru,
      thonBuon: thonBuon ?? this.thonBuon,
      xaPhuong: xaPhuong ?? this.xaPhuong,
      huyenThiThanhPho: huyenThiThanhPho ?? this.huyenThiThanhPho,
      tinh: tinh ?? this.tinh,
      dkxkldChuyenmon: dkxkldChuyenmon ?? this.dkxkldChuyenmon,
      dkxkldBacdaotao: dkxkldBacdaotao ?? this.dkxkldBacdaotao,
      dkxkldDangdoan: dkxkldDangdoan ?? this.dkxkldDangdoan,
      dkxkldNganhnghemongmuon:
          dkxkldNganhnghemongmuon ?? this.dkxkldNganhnghemongmuon,
      dkxkldNndaduocdaotao:
          dkxkldNndaduocdaotao ?? this.dkxkldNndaduocdaotao,
      idNganhKinhTe: idNganhKinhTe ?? this.idNganhKinhTe,
      vitrimongmuon: vitrimongmuon ?? this.vitrimongmuon,
      viecdanglam: viecdanglam ?? this.viecdanglam,
      dkxkldGhichu: dkxkldGhichu ?? this.dkxkldGhichu,
      dkxkldSolanxem: dkxkldSolanxem ?? this.dkxkldSolanxem,
      dkxkldhtTelephone: dkxkldhtTelephone ?? this.dkxkldhtTelephone,
      dkxkldhtEmail: dkxkldhtEmail ?? this.dkxkldhtEmail,
      dkxkldhtAddress: dkxkldhtAddress ?? this.dkxkldhtAddress,
      daXuatCanh: daXuatCanh ?? this.daXuatCanh,
      ngayXuatCanh: ngayXuatCanh ?? this.ngayXuatCanh,
      daXem: daXem ?? this.daXem,
      idDoanhNghiep: idDoanhNghiep ?? this.idDoanhNghiep,
      ngayGioiThieu: ngayGioiThieu ?? this.ngayGioiThieu,
      nguoiBaoLanh: nguoiBaoLanh ?? this.nguoiBaoLanh,
      dienthoailienhe: dienthoailienhe ?? this.dienthoailienhe,
      datSoTuyen: datSoTuyen ?? this.datSoTuyen,
      venuoc: venuoc ?? this.venuoc,
      ngayvenuoc: ngayvenuoc ?? this.ngayvenuoc,
      lydovenuoc: lydovenuoc ?? this.lydovenuoc,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }
}
