class M03PLIModel {
  final String idphieu;
  final DateTime ngaylap;
  final String madk;
  final String idDoanhnghiep;
  final String idDn;
  final String tenDn;
  final String tenGd;
  final String masothue;
  final String idLhdn;
  final String matinh;
  final String mahuyen;
  final String maxa;
  final int idKhuCn;
  final String diachiDn;
  final String idNkt;
  final bool chkNl;
  final bool chkCn;
  final bool chkSxpp;
  final bool chkVtkb;
  final bool chkTttt;
  final bool chkBds;
  final bool chkDvhc;
  final bool chkYt;
  final bool chkBbl;
  final bool chkThue;
  final bool chkKk;
  final bool chkXd;
  final bool chkCcn;
  final bool chkDvlt;
  final bool chkTcnh;
  final bool chkKhcn;
  final bool chkGd;
  final bool chkNt;
  final bool chkHdxh;
  final bool chkDv;
  final bool chkHdqt;
  final int idQuymo;
  final int soluong;
  final DateTime ngaydky;
  final bool chkTuvanCs;
  final bool chkTuvanVl;
  final bool chkTuvanDt;
  final bool chkDKy03A;
  final String dKyKhac;
  final String tenLienhe;
  final String chucvu;
  final String dienthoai;
  final String email;
  final bool nhanSms;
  final bool nhanEMail;
  final String hinhthuckhac;
  final String userName;
  final int displayOrder;
  final DateTime createdDate;
  final String createdBy;
  final DateTime modifiredDate;
  final String modifiredBy;
  final bool status;

  M03PLIModel({
    required this.idphieu,
    required this.ngaylap,
    required this.madk,
    required this.idDoanhnghiep,
    required this.idDn,
    required this.tenDn,
    required this.tenGd,
    required this.masothue,
    required this.idLhdn,
    required this.matinh,
    required this.mahuyen,
    required this.maxa,
    required this.idKhuCn,
    required this.diachiDn,
    required this.idNkt,
    required this.chkNl,
    required this.chkCn,
    required this.chkSxpp,
    required this.chkVtkb,
    required this.chkTttt,
    required this.chkBds,
    required this.chkDvhc,
    required this.chkYt,
    required this.chkBbl,
    required this.chkThue,
    required this.chkKk,
    required this.chkXd,
    required this.chkCcn,
    required this.chkDvlt,
    required this.chkTcnh,
    required this.chkKhcn,
    required this.chkGd,
    required this.chkNt,
    required this.chkHdxh,
    required this.chkDv,
    required this.chkHdqt,
    required this.idQuymo,
    required this.soluong,
    required this.ngaydky,
    required this.chkTuvanCs,
    required this.chkTuvanVl,
    required this.chkTuvanDt,
    required this.chkDKy03A,
    required this.dKyKhac,
    required this.tenLienhe,
    required this.chucvu,
    required this.dienthoai,
    required this.email,
    required this.nhanSms,
    required this.nhanEMail,
    required this.hinhthuckhac,
    required this.userName,
    required this.displayOrder,
    required this.createdDate,
    required this.createdBy,
    required this.modifiredDate,
    required this.modifiredBy,
    required this.status,
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
      'ngaylap': ngaylap.toIso8601String(),
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
      chkDv: chkDv,
      'chkHdqt': chkHdqt,
      'idQuymo': idQuymo,
      'soluong': soluong,
      'ngaydky': ngaydky.toIso8601String(),
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
      'createdDate': createdDate.toIso8601String(),
      'createdBy': createdBy,
      'modifiredDate': modifiredDate.toIso8601String(),
      'modifiredBy': modifiredBy,
      'status': status,
    };
  }
}
