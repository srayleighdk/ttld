class M03PLIModel {
  String? idphieu;
  DateTime? ngaylap;
  String? madk;
  String? idDoanhnghiep;
  String? idDn;
  String? tenDn;
  String? tenGd;
  String? masothue;
  String? idLhdn;
  String? matinh;
  String? mahuyen;
  String? maxa;
  int? idKhuCn;
  String? diachiDn;
  String? idNkt;
  bool? chkNl;
  bool? chkCn;
  bool? chkSxpp;
  bool? chkVtkb;
  bool? chkTttt;
  bool? chkBds;
  bool? chkDvhc;
  bool? chkYt;
  bool? chkBbl;
  bool? chkThue;
  bool? chkKk;
  bool? chkXd;
  bool? chkCcn;
  bool? chkDvlt;
  bool? chkTcnh;
  bool? chkKhcn;
  bool? chkGd;
  bool? chkNt;
  bool? chkHdxh;
  bool? chkDv;
  bool? chkHdqt;
  int? idQuymo;
  int? soluong;
  DateTime? ngaydky;
  bool? chkTuvanCs;
  bool? chkTuvanVl;
  bool? chkTuvanDt;
  bool? chkDKy03A;
  String? dKyKhac;
  String? tenLienhe;
  String? chucvu;
  String? dienthoai;
  String? email;
  bool? nhanSms;
  bool? nhanEMail;
  String? hinhthuckhac;
  String? userName;
  int? displayOrder;
  DateTime? createdDate;
  String? createdBy;
  DateTime? modifiredDate;
  String? modifiredBy;
  bool? status;

  M03PLIModel({
    this.idphieu,
    this.ngaylap,
    this.madk,
    this.idDoanhnghiep,
    this.idDn,
    this.tenDn,
    this.tenGd,
    this.masothue,
    this.idLhdn,
    this.matinh,
    this.mahuyen,
    this.maxa,
    this.idKhuCn,
    this.diachiDn,
    this.idNkt,
    this.chkNl,
    this.chkCn,
    this.chkSxpp,
    this.chkVtkb,
    this.chkTttt,
    this.chkBds,
    this.chkDvhc,
    this.chkYt,
    this.chkBbl,
    this.chkThue,
    this.chkKk,
    this.chkXd,
    this.chkCcn,
    this.chkDvlt,
    this.chkTcnh,
    this.chkKhcn,
    this.chkGd,
    this.chkNt,
    this.chkHdxh,
    this.chkDv,
    this.chkHdqt,
    this.idQuymo,
    this.soluong,
    this.ngaydky,
    this.chkTuvanCs,
    this.chkTuvanVl,
    this.chkTuvanDt,
    this.chkDKy03A,
    this.dKyKhac,
    this.tenLienhe,
    this.chucvu,
    this.dienthoai,
    this.email,
    this.nhanSms,
    this.nhanEMail,
    this.hinhthuckhac,
    this.userName,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.modifiredDate,
    this.modifiredBy,
    this.status,
  });

  factory M03PLIModel.fromJson(Map<String, dynamic> json) {
    return M03PLIModel(
      idphieu: json['idphieu'] as String,
      ngaylap: DateTime.parse(json['ngaylap'] as String),
      madk: json['madk'] as String,
      idDoanhnghiep: json['idDoanhnghiep'] as String,
      idDn: json['idDn'] as String,
      tenDn: json['tenDn'] as String,
      tenGd: json['tenGd'] as String,
      masothue: json['masothue'] as String,
      idLhdn: json['idLhdn'] as String,
      matinh: json['matinh'] as String,
      mahuyen: json['mahuyen'] as String,
      maxa: json['maxa'] as String,
      idKhuCn: json['idKhuCn'] as int,
      diachiDn: json['diachiDn'] as String,
      idNkt: json['idNkt'] as String,
      chkNl: json['chkNl'] as bool,
      chkCn: json['chkCn'] as bool,
      chkSxpp: json['chkSxpp'] as bool,
      chkVtkb: json['chkVtkb'] as bool,
      chkTttt: json['chkTttt'] as bool,
      chkBds: json['chkBds'] as bool,
      chkDvhc: json['chkDvhc'] as bool,
      chkYt: json['chkYt'] as bool,
      chkBbl: json['chkBbl'] as bool,
      chkThue: json['chkThue'] as bool,
      chkKk: json['chkKk'] as bool,
      chkXd: json['chkXd'] as bool,
      chkCcn: json['chkCcn'] as bool,
      chkDvlt: json['chkDvlt'] as bool,
      chkTcnh: json['chkTcnh'] as bool,
      chkKhcn: json['chkKhcn'] as bool,
      chkGd: json['chkGd'] as bool,
      chkNt: json['chkNt'] as bool,
      chkHdxh: json['chkHdxh'] as bool,
      chkDv: json['chkDv'] as bool,
      chkHdqt: json['chkHdqt'] as bool,
      idQuymo: json['idQuymo'] as int,
      soluong: json['soluong'] as int,
      ngaydky: DateTime.parse(json['ngaydky'] as String),
      chkTuvanCs: json['chkTuvanCs'] as bool,
      chkTuvanVl: json['chkTuvanVl'] as bool,
      chkTuvanDt: json['chkTuvanDt'] as bool,
      chkDKy03A: json['chkDKy03A'] as bool,
      dKyKhac: json['dKyKhac'] as String,
      tenLienhe: json['tenLienhe'] as String,
      chucvu: json['chucvu'] as String,
      dienthoai: json['dienthoai'] as String,
      email: json['email'] as String,
      nhanSms: json['nhanSms'] as bool,
      nhanEMail: json['nhanEMail'] as bool,
      hinhthuckhac: json['hinhthuckhac'] as String,
      userName: json['userName'] as String,
      displayOrder: json['displayOrder'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String,
      modifiredDate: DateTime.parse(json['modifiredDate'] as String),
      modifiredBy: json['modifiredBy'] as String,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idphieu': idphieu,
      'ngaylap': ngaylap?.toIso8601String(),
      'madk': madk,
      'idDoanhnghiep': idDoanhnghiep,
      'idDn': idDn,
      'tenDn': tenDn,
      'tenGd': tenGd,
      'masothue': masothue,
      'idLhdn': idLhdn,
      'matinh': matinh,
      'mahuyen': mahuyen,
      'maxa': maxa,
      'idKhuCn': idKhuCn,
      'diachiDn': diachiDn,
      'idNkt': idNkt,
      'chkNl': chkNl,
      'chkCn': chkCn,
      'chkSxpp': chkSxpp,
      'chkVtkb': chkVtkb,
      'chkTttt': chkTttt,
      'chkBds': chkBds,
      'chkDvhc': chkDvhc,
      'chkYt': chkYt,
      'chkBbl': chkBbl,
      'chkThue': chkThue,
      'chkKk': chkKk,
      'chkXd': chkXd,
      'chkCcn': chkCcn,
      'chkDvlt': chkDvlt,
      'chkTcnh': chkTcnh,
      'chkKhcn': chkKhcn,
      'chkGd': chkGd,
      'chkNt': chkNt,
      'chkHdxh': chkHdxh,
      'chkDv': chkDv,
      'chkHdqt': chkHdqt,
      'idQuymo': idQuymo,
      'soluong': soluong,
      'ngaydky': ngaydky?.toIso8601String(),
      'chkTuvanCs': chkTuvanCs,
      'chkTuvanVl': chkTuvanVl,
      'chkTuvanDt': chkTuvanDt,
      'chkDKy03A': chkDKy03A,
      'dKyKhac': dKyKhac,
      'tenLienhe': tenLienhe,
      'chucvu': chucvu,
      'dienthoai': dienthoai,
      'email': email,
      'nhanSms': nhanSms,
      'nhanEMail': nhanEMail,
      'hinhthuckhac': hinhthuckhac,
      'userName': userName,
      'displayOrder': displayOrder,
      'createdDate': createdDate?.toIso8601String(),
      'createdBy': createdBy,
      'modifiredDate': modifiredDate?.toIso8601String(),
      'modifiredBy': modifiredBy,
      'status': status,
    };
  }
}
