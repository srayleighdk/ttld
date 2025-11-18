class DkyHocNghe {
  final String id;
  final int? idloai;
  final DateTime ngaydangky;
  final String? idHoSo;
  final String idUv;
  final String hoTen;
  final String soCmnd;
  final DateTime? ngaycap;
  final String? noicap;
  final String? soBhxh;
  final String? diaChiThuongTru;
  final String? diaChiHienTai;
  final String? soDienThoai;
  final int? soQdhtctn;
  final DateTime? ngayky;
  final int? soThangHuong;
  final DateTime? huongTuNgay;
  final DateTime? huongDenNgay;
  final int? soThangDong;
  final int? idNghedaotao;
  final String? tenNghedaotao;
  final int? soThangHocNghe;
  final String? idCosodaotao;
  final String? tenCosodaotao;
  final String? trinhDoDaoTao;
  final int displayOrder;
  final bool status;
  final bool duyetdangky;
  final int? idDoituongCs;
  final String? trangThai;

  DkyHocNghe({
    required this.id,
    this.idloai,
    required this.ngaydangky,
    this.idHoSo,
    required this.idUv,
    required this.hoTen,
    required this.soCmnd,
    this.ngaycap,
    this.noicap,
    this.soBhxh,
    this.diaChiThuongTru,
    this.diaChiHienTai,
    this.soDienThoai,
    this.soQdhtctn,
    this.ngayky,
    this.soThangHuong,
    this.huongTuNgay,
    this.huongDenNgay,
    this.soThangDong,
    this.idNghedaotao,
    this.tenNghedaotao,
    this.soThangHocNghe,
    this.idCosodaotao,
    this.tenCosodaotao,
    this.trinhDoDaoTao,
    this.displayOrder = 1,
    this.status = true,
    this.duyetdangky = false,
    this.idDoituongCs,
    this.trangThai,
  });

  factory DkyHocNghe.fromJson(Map<String, dynamic> json) {
    return DkyHocNghe(
      id: json['id']?.toString() ?? '',
      idloai: json['idloai'],
      ngaydangky: json['ngaydangky'] != null
          ? DateTime.parse(json['ngaydangky'])
          : DateTime.now(),
      idHoSo: json['idHoSo'],
      idUv: json['idUv'] ?? '',
      hoTen: json['hoTen'] ?? '',
      soCmnd: json['soCmnd'] ?? '',
      ngaycap: json['ngaycap'] != null ? DateTime.parse(json['ngaycap']) : null,
      noicap: json['noicap'],
      soBhxh: json['soBhxh'],
      diaChiThuongTru: json['diaChiThuongTru'],
      diaChiHienTai: json['diaChiHienTai'],
      soDienThoai: json['soDienThoai'],
      soQdhtctn: json['soQdhtctn'],
      ngayky: json['ngayky'] != null ? DateTime.parse(json['ngayky']) : null,
      soThangHuong: json['soThangHuong'],
      huongTuNgay: json['huongTuNgay'] != null
          ? DateTime.parse(json['huongTuNgay'])
          : null,
      huongDenNgay: json['huongDenNgay'] != null
          ? DateTime.parse(json['huongDenNgay'])
          : null,
      soThangDong: json['soThangDong'],
      idNghedaotao: json['idNghedaotao'],
      tenNghedaotao: json['tenNghedaotao'] ?? json['nghedaotao']?['nnTen'],
      soThangHocNghe: json['soThangHocNghe'],
      idCosodaotao: json['idCosodaotao'],
      tenCosodaotao: json['tenCosodaotao'] ?? json['cosodaotao']?['name'],
      trinhDoDaoTao: json['trinhDoDaoTao'] ?? json['nghedaotao']?['bachoc'],
      displayOrder: json['displayOrder'] ?? 1,
      status: json['status'] ?? true,
      duyetdangky: json['duyetdangky'] ?? false,
      idDoituongCs: json['idDoituongCs'],
      trangThai: json['trangThai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idloai': idloai,
      'ngaydangky': ngaydangky.toIso8601String(),
      'idHoSo': idHoSo,
      'idUv': idUv,
      'hoTen': hoTen,
      'soCmnd': soCmnd,
      'ngaycap': ngaycap?.toIso8601String(),
      'noicap': noicap,
      'soBhxh': soBhxh,
      'diaChiThuongTru': diaChiThuongTru,
      'diaChiHienTai': diaChiHienTai,
      'soDienThoai': soDienThoai,
      'soQdhtctn': soQdhtctn,
      'ngayky': ngayky?.toIso8601String(),
      'soThangHuong': soThangHuong,
      'huongTuNgay': huongTuNgay?.toIso8601String(),
      'huongDenNgay': huongDenNgay?.toIso8601String(),
      'soThangDong': soThangDong,
      'idNghedaotao': idNghedaotao,
      'soThangHocNghe': soThangHocNghe,
      'idCosodaotao': idCosodaotao,
      'displayOrder': displayOrder,
      'status': status,
      'duyetdangky': duyetdangky,
      'idDoituongCs': idDoituongCs,
    };
  }
}
