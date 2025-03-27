class M02Pli {
  final String? idphieu;
  final String? ngaylap;
  final String? maso;
  final String? noiden;
  final int? soluong;
  final String? daidien;
  final String? diachiLh;
  final String? dienthoai;
  final String? email;
  final String? tenLienkhac;
  final bool? chkTuvanCs;
  final bool? chkTuvanVl;
  final bool? chkTuvanDt;
  final bool? chkTuvankhac;
  final String? dKyKhac;
  final String? thoigianDk;
  final String? userName;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? modifiredDate;
  final String? modifiredBy;
  final bool? status;

  M02Pli({
    required this.idphieu,
    required this.ngaylap,
    required this.maso,
    required this.noiden,
    required this.soluong,
    required this.daidien,
    required this.diachiLh,
    required this.dienthoai,
    required this.email,
    required this.tenLienkhac,
    required this.chkTuvanCs,
    required this.chkTuvanVl,
    required this.chkTuvanDt,
    required this.chkTuvankhac,
    required this.dKyKhac,
    required this.thoigianDk,
    required this.userName,
    required this.displayOrder,
    required this.createdDate,
    required this.createdBy,
    required this.modifiredDate,
    required this.modifiredBy,
    required this.status,
  });

  factory M02Pli.fromJson(Map<String, dynamic> json) {
    return M02Pli(
      idphieu: json['idphieu'],
      ngaylap: json['ngaylap'],
      maso: json['maso'],
      noiden: json['noiden'],
      soluong: json['soluong'],
      daidien: json['daidien'],
      diachiLh: json['diachiLh'],
      dienthoai: json['dienthoai'],
      email: json['email'],
      tenLienkhac: json['tenLienkhac'],
      chkTuvanCs: json['chkTuvanCs'],
      chkTuvanVl: json['chkTuvanVl'],
      chkTuvanDt: json['chkTuvanDt'],
      chkTuvankhac: json['chkTuvankhac'],
      dKyKhac: json['dKyKhac'],
      thoigianDk: json['thoigianDk'],
      userName: json['userName'],
      displayOrder: json['displayOrder'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      modifiredDate: json['modifiredDate'],
      modifiredBy: json['modifiredBy'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'idphieu': idphieu,
    'ngaylap': ngaylap,
    'maso': maso,
    'noiden': noiden,
    'soluong': soluong,
    'daidien': daidien,
    'diachiLh': diachiLh,
    'dienthoai': dienthoai,
    'email': email,
    'tenLienkhac': tenLienkhac,
    'chkTuvanCs': chkTuvanCs,
    'chkTuvanVl': chkTuvanVl,
    'chkTuvanDt': chkTuvanDt,
    'chkTuvankhac': chkTuvankhac,
    'dKyKhac': dKyKhac,
    'thoigianDk': thoigianDk,
    'userName': userName,
    'displayOrder': displayOrder,
    'createdDate': createdDate,
    'createdBy': createdBy,
    'modifiredDate': modifiredDate,
    'modifiredBy': modifiredBy,
    'status': status,
  };
}
