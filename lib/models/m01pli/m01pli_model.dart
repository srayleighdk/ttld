class M01Pli {
  final String? idphieu;
  final String? idM02T11;
  final String? ngaylap;
  final String? maphieu;
  final String? iduv;
  final String? hoten;
  final String? soCmnd;
  final String? ngaysinh;
  final int? idGioitinh;
  final int? idDantoc;
  final int? idTongiao;
  final String? matinhHk;
  final String? mahuyenHk;
  final String? maxaHk;
  final String? diachiHk;
  final String? matinhTt;
  final String? mahuyenTt;
  final String? maxaTt;
  final String? diachiTt;
  final String? tenLienhe;
  final String? dienthoai;
  final String? email;
  final int? idDoituong;
  final int? idhocvan;
  final String? idBacHoc;
  final int? idChuyenmon;
  final String? idBacHocKhac;
  final int? idChuyenmonKhac;
  final String? trinhdok1;
  final String? trinhdok2;
  final String? kynangnghe;
  final int? backynang;
  final int? idNndt1;
  final String? idTdnn1;
  final int? mucNn1;
  final int? idNndt2;
  final String? idTdnn2;
  final int? mucNn2;
  final String? idTdth;
  final int? mucTh;
  final String? idKynang;
  final bool? chkGt;
  final bool? chkNs;
  final bool? chkNhom;
  final bool? chkGs;
  final bool? chkKhac;
  final bool? chkTtr;
  final bool? chkTh;
  final bool? chkDl;
  final bool? chkPb;
  final bool? chkQltg;
  final bool? chkTu;
  final bool? chkApl;
  final String? kynangkhac;
  final dynamic kinhnghiemLv;
  final bool? lvNuocngoai;
  final int? idQuocgia;
  final String? lvNuocngoaitai;
  final bool? chkTuvanCs;
  final bool? chkTuvanVl;
  final bool? chkTuvanDt;
  final bool? chkDKy01A;
  final String? dKyKhac;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? modifiredDate;
  final String? modifiredBy;
  final String? mahoGd;
  final bool? status;
  final List<dynamic> tblM01Plikns;

  M01Pli({
    required this.idphieu,
    required this.idM02T11,
    required this.ngaylap,
    required this.maphieu,
    required this.iduv,
    required this.hoten,
    required this.soCmnd,
    required this.ngaysinh,
    required this.idGioitinh,
    required this.idDantoc,
    required this.idTongiao,
    required this.matinhHk,
    required this.mahuyenHk,
    required this.maxaHk,
    required this.diachiHk,
    required this.matinhTt,
    required this.mahuyenTt,
    required this.maxaTt,
    required this.diachiTt,
    required this.tenLienhe,
    required this.dienthoai,
    required this.email,
    required this.idDoituong,
    required this.idhocvan,
    required this.idBacHoc,
    required this.idChuyenmon,
    required this.idBacHocKhac,
    required this.idChuyenmonKhac,
    required this.trinhdok1,
    required this.trinhdok2,
    required this.kynangnghe,
    required this.backynang,
    required this.idNndt1,
    required this.idTdnn1,
    required this.mucNn1,
    required this.idNndt2,
    required this.idTdnn2,
    required this.mucNn2,
    required this.idTdth,
    required this.mucTh,
    required this.idKynang,
    required this.chkGt,
    required this.chkNs,
    required this.chkNhom,
    required this.chkGs,
    required this.chkKhac,
    required this.chkTtr,
    required this.chkTh,
    required this.chkDl,
    required this.chkPb,
    required this.chkQltg,
    required this.chkTu,
    required this.chkApl,
    required this.kynangkhac,
    required this.kinhnghiemLv,
    required this.lvNuocngoai,
    required this.idQuocgia,
    required this.lvNuocngoaitai,
    required this.chkTuvanCs,
    required this.chkTuvanVl,
    required this.chkTuvanDt,
    required this.chkDKy01A,
    required this.dKyKhac,
    required this.displayOrder,
    required this.createdDate,
    required this.createdBy,
    required this.modifiredDate,
    required this.modifiredBy,
    required this.mahoGd,
    required this.status,
    required this.tblM01Plikns,
  });

  factory M01Pli.fromJson(Map<String, dynamic> json) {
    return M01Pli(
      idphieu: json['idphieu'],
      idM02T11: json['idM02T11'],
      ngaylap: json['ngaylap'],
      maphieu: json['maphieu'],
      iduv: json['iduv'],
      hoten: json['hoten'],
      soCmnd: json['soCmnd'],
      ngaysinh: json['ngaysinh'],
      idGioitinh: json['idGioitinh'],
      idDantoc: json['idDantoc'],
      idTongiao: json['idTongiao'],
      matinhHk: json['matinhHk'],
      mahuyenHk: json['mahuyenHk'],
      maxaHk: json['maxaHk'],
      diachiHk: json['diachiHk'],
      matinhTt: json['matinhTt'],
      mahuyenTt: json['mahuyenTt'],
      maxaTt: json['maxaTt'],
      diachiTt: json['diachiTt'],
      tenLienhe: json['tenLienhe'],
      dienthoai: json['dienthoai'],
      email: json['email'],
      idDoituong: json['idDoituong'],
      idhocvan: json['idhocvan'],
      idBacHoc: json['idBacHoc'],
      idChuyenmon: json['idChuyenmon'],
      idBacHocKhac: json['idBacHocKhac'],
      idChuyenmonKhac: json['idChuyenmonKhac'],
      trinhdok1: json['trinhdok1'],
      trinhdok2: json['trinhdok2'],
      kynangnghe: json['kynangnghe'],
      backynang: json['backynang'],
      idNndt1: json['idNndt1'],
      idTdnn1: json['idTdnn1'],
      mucNn1: json['mucNn1'],
      idNndt2: json['idNndt2'],
      idTdnn2: json['idTdnn2'],
      mucNn2: json['mucNn2'],
      idTdth: json['idTdth'],
      mucTh: json['mucTh'],
      idKynang: json['idKynang'],
      chkGt: json['chkGt'],
      chkNs: json['chkNs'],
      chkNhom: json['chkNhom'],
      chkGs: json['chkGs'],
      chkKhac: json['chkKhac'],
      chkTtr: json['chkTtr'],
      chkTh: json['chkTh'],
      chkDl: json['chkDl'],
      chkPb: json['chkPb'],
      chkQltg: json['chkQltg'],
      chkTu: json['chkTu'],
      chkApl: json['chkApl'],
      kynangkhac: json['kynangkhac'],
      kinhnghiemLv: json['kinhnghiemLv'],
      lvNuocngoai: json['lvNuocngoai'],
      idQuocgia: json['idQuocgia'],
      lvNuocngoaitai: json['lvNuocngoaitai'],
      chkTuvanCs: json['chkTuvanCs'],
      chkTuvanVl: json['chkTuvanVl'],
      chkTuvanDt: json['chkTuvanDt'],
      chkDKy01A: json['chkDKy01A'],
      dKyKhac: json['dKyKhac'],
      displayOrder: json['displayOrder'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      modifiredDate: json['modifiredDate'],
      modifiredBy: json['modifiredBy'],
      mahoGd: json['mahoGd'],
      status: json['status'],
      tblM01Plikns: json['tblM01Plikns'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'idphieu': idphieu,
    'idM02T11': idM02T11,
    'ngaylap': ngaylap,
    'maphieu': maphieu,
    'iduv': iduv,
    'hoten': hoten,
    'soCmnd': soCmnd,
    'ngaysinh': ngaysinh,
    'idGioitinh': idGioitinh,
    'idDantoc': idDantoc,
    'idTongiao': idTongiao,
    'matinhHk': matinhHk,
    'mahuyenHk': mahuyenHk,
    'maxaHk': maxaHk,
    'diachiHk': diachiHk,
    'matinhTt': matinhTt,
    'mahuyenTt': mahuyenTt,
    'maxaTt': maxaTt,
    'diachiTt': diachiTt,
    'tenLienhe': tenLienhe,
    'dienthoai': dienthoai,
    'email': email,
    'idDoituong': idDoituong,
    'idhocvan': idhocvan,
    'idBacHoc': idBacHoc,
    'idChuyenmon': idChuyenmon,
    'idBacHocKhac': idBacHocKhac,
    'idChuyenmonKhac': idChuyenmonKhac,
    'trinhdok1': trinhdok1,
    'trinhdok2': trinhdok2,
    'kynangnghe': kynangnghe,
    'backynang': backynang,
    'idNndt1': idNndt1,
    'idTdnn1': idTdnn1,
    'mucNn1': mucNn1,
    'idNndt2': idNndt2,
    'idTdnn2': idTdnn2,
    'mucNn2': mucNn2,
    'idTdth': idTdth,
    'mucTh': mucTh,
    'idKynang': idKynang,
    'chkGt': chkGt,
    'chkNs': chkNs,
    'chkNhom': chkNhom,
    'chkGs': chkGs,
    'chkKhac': chkKhac,
    'chkTtr': chkTtr,
    'chkTh': chkTh,
    'chkDl': chkDl,
    'chkPb': chkPb,
    'chkQltg': chkQltg,
    'chkTu': chkTu,
    'chkApl': chkApl,
    'kynangkhac': kynangkhac,
    'kinhnghiemLv': kinhnghiemLv,
    'lvNuocngoai': lvNuocngoai,
    'idQuocgia': idQuocgia,
    'lvNuocngoaitai': lvNuocngoaitai,
    'chkTuvanCs': chkTuvanCs,
    'chkTuvanVl': chkTuvanVl,
    'chkTuvanDt': chkTuvanDt,
    'chkDKy01A': chkDKy01A,
    'dKyKhac': dKyKhac,
    'displayOrder': displayOrder,
    'createdDate': createdDate,
    'createdBy': createdBy,
    'modifiredDate': modifiredDate,
    'modifiredBy': modifiredBy,
    'mahoGd': mahoGd,
    'status': status,
    'tblM01Plikns': tblM01Plikns,
  };
}
