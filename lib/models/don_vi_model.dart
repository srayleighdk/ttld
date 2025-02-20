class DonVi {
  final int sott;
  final int idCapQl;
  final String macaptren;
  final String tencaptren;
  final String madonvi;
  final String tendonvi;
  final String tenReport;
  final String diachi;
  final String dienthoai;
  final String email;
  final String masothue;
  final String sotk;
  final String nganhang;
  final String chucdanhLd;
  final String tenLd;
  final String chucdanhKt;
  final String tenKt;
  final String chucdanhQt;
  final String tenQt;
  final String emailDefault;
  final String passwordDefault;
  final String smtpServer;
  final int smtpPort;
  final bool enableSsl;
  final bool smtpUseDefaultCredentials;
  final String emailUser;
  final String emailPassword;
  final String maTinh;
  final String maHuyen;
  final String maXa;
  final String thonbuon;
  final String? logoUrl;
  final bool status;

  DonVi({
    required this.sott,
    required this.idCapQl,
    required this.macaptren,
    required this.tencaptren,
    required this.madonvi,
    required this.tendonvi,
    required this.tenReport,
    required this.diachi,
    required this.dienthoai,
    required this.email,
    required this.masothue,
    required this.sotk,
    required this.nganhang,
    required this.chucdanhLd,
    required this.tenLd,
    required this.chucdanhKt,
    required this.tenKt,
    required this.chucdanhQt,
    required this.tenQt,
    required this.emailDefault,
    required this.passwordDefault,
    required this.smtpServer,
    required this.smtpPort,
    required this.enableSsl,
    required this.smtpUseDefaultCredentials,
    required this.emailUser,
    required this.emailPassword,
    required this.maTinh,
    required this.maHuyen,
    required this.maXa,
    required this.thonbuon,
    this.logoUrl,
    required this.status,
  });

  factory DonVi.fromJson(Map<String, dynamic> json) {
    return DonVi(
      sott: json['sott'],
      idCapQl: json['idCapQl'],
      macaptren: json['macaptren'],
      tencaptren: json['tencaptren'],
      madonvi: json['madonvi'],
      tendonvi: json['tendonvi'],
      tenReport: json['tenReport'],
      diachi: json['diachi'],
      dienthoai: json['dienthoai'],
      email: json['email'],
      masothue: json['masothue'],
      sotk: json['sotk'],
      nganhang: json['nganhang'],
      chucdanhLd: json['chucdanhLd'],
      tenLd: json['tenLd'],
      chucdanhKt: json['chucdanhKt'],
      tenKt: json['tenKt'],
      chucdanhQt: json['chucdanhQt'],
      tenQt: json['tenQt'],
      emailDefault: json['emailDefault'],
      passwordDefault: json['passwordDefault'],
      smtpServer: json['smtpServer'],
      smtpPort: json['smtpPort'],
      enableSsl: json['enableSsl'],
      smtpUseDefaultCredentials: json['smtpUseDefaultCredentials'],
      emailUser: json['emailUser'],
      emailPassword: json['emailPassword'],
      maTinh: json['maTinh'],
      maHuyen: json['maHuyen'],
      maXa: json['maXa'],
      thonbuon: json['thonbuon'],
      logoUrl: json['logoUrl'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sott': sott,
      'idCapQl': idCapQl,
      'macaptren': macaptren,
      'tencaptren': tencaptren,
      'madonvi': madonvi,
      'tendonvi': tendonvi,
      'tenReport': tenReport,
      'diachi': diachi,
      'dienthoai': dienthoai,
      'email': email,
      'masothue': masothue,
      'sotk': sotk,
      'nganhang': nganhang,
      'chucdanhLd': chucdanhLd,
      'tenLd': tenLd,
      'chucdanhKt': chucdanhKt,
      'tenKt': tenKt,
      'chucdanhQt': chucdanhQt,
      'tenQt': tenQt,
      'emailDefault': emailDefault,
      'passwordDefault': passwordDefault,
      'smtpServer': smtpServer,
      'smtpPort': smtpPort,
      'enableSsl': enableSsl,
      'smtpUseDefaultCredentials': smtpUseDefaultCredentials,
      'emailUser': emailUser,
      'emailPassword': emailPassword,
      'maTinh': maTinh,
      'maHuyen': maHuyen,
      'maXa': maXa,
      'thonbuon': thonbuon,
      'logoUrl': logoUrl,
      'status': status,
    };
  }
}
