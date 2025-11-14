class HosoDTNModel {
  String? id;
  int? idloai;
  String? dkdtnNgay;
  String? dkdtnUsername;
  String? dkdtnEmail;
  String? dkdtnPassword;
  String? dkdtnHoten;
  String? imagePath;
  String? dkdtnNgaysinh;
  String? dkdtnChuyenmon;
  String? dkdtnDienthoai;
  int? dkdtnDantoc;
  int? dkdtnTongiao;
  String? dkdtnHokhauthuongtru;
  int? dkdtndmNghenganhan;
  int? dkdtndmNghesocap;
  String? dkdtnGhichu;
  bool? dkdtnhtTelephone;
  bool? dkdtnhtEmail;
  bool? dkdtnhtAddress;
  String? soNhaDuong;
  String? maTinh;
  String? maHuyen;
  String? maXa;
  int? idDaoTao;
  String? nguyenQuan;
  String? idTdNgoaiNgu;
  String? chieuCao;
  String? canNang;
  String? matTrai;
  String? matPhai;
  String? muMau;
  String? hoTenCha;
  String? hoTenMe;
  String? diaChiBaoTin;
  String? dienThoaiBaoTin;
  String? tinNhanBaoTin;
  String? soHoChieu;
  bool? docThan;
  bool? daCoGiaDinh;
  bool? daLyDi;
  int? soCon;
  String? daLamViecONuocNgoai;
  bool? coBhtn;
  String? idtv;
  int? dkStatus;
  String? dkngonngu;
  bool? duyetdangky;
  int? dkdtndmDoituongchinhsach;
  int? dkdtndmTruong;
  int? dkdtnGioitinh;
  int? dkdtnDuyet;
  bool? idTrangThaiTrungTuyen;
  int? dkdtndmTrinhdohocvanDtn;
  int? dkdtndmNghedaotao;
  int? dkdtndmNganhcaodang;
  int? dkdtndmNganhtrungcap;

  HosoDTNModel({
    this.id,
    this.idloai,
    this.dkdtnNgay,
    this.dkdtnUsername,
    this.dkdtnEmail,
    this.dkdtnPassword,
    this.dkdtnHoten,
    this.imagePath,
    this.dkdtnNgaysinh,
    this.dkdtnChuyenmon,
    this.dkdtnDienthoai,
    this.dkdtnDantoc,
    this.dkdtnTongiao,
    this.dkdtnHokhauthuongtru,
    this.dkdtndmNghenganhan,
    this.dkdtndmNghesocap,
    this.dkdtnGhichu,
    this.dkdtnhtTelephone,
    this.dkdtnhtEmail,
    this.dkdtnhtAddress,
    this.soNhaDuong,
    this.maTinh,
    this.maHuyen,
    this.maXa,
    this.idDaoTao,
    this.nguyenQuan,
    this.idTdNgoaiNgu,
    this.chieuCao,
    this.canNang,
    this.matTrai,
    this.matPhai,
    this.muMau,
    this.hoTenCha,
    this.hoTenMe,
    this.diaChiBaoTin,
    this.dienThoaiBaoTin,
    this.tinNhanBaoTin,
    this.soHoChieu,
    this.docThan,
    this.daCoGiaDinh,
    this.daLyDi,
    this.soCon,
    this.daLamViecONuocNgoai,
    this.coBhtn,
    this.idtv,
    this.dkStatus,
    this.dkngonngu,
    this.duyetdangky,
    this.dkdtndmDoituongchinhsach,
    this.dkdtndmTruong,
    this.dkdtnGioitinh,
    this.dkdtnDuyet,
    this.idTrangThaiTrungTuyen,
    this.dkdtndmTrinhdohocvanDtn,
    this.dkdtndmNghedaotao,
    this.dkdtndmNganhcaodang,
    this.dkdtndmNganhtrungcap,
  });

  factory HosoDTNModel.fromJson(Map<String, dynamic> json) {
    return HosoDTNModel(
      id: json['id'] as String?,
      idloai: json['idloai'] as int?,
      dkdtnNgay: json['dkdtnNgay'] as String?,
      dkdtnUsername: json['dkdtnUsername'] as String?,
      dkdtnEmail: json['dkdtnEmail'] as String?,
      dkdtnPassword: json['dkdtnPassword'] as String?,
      dkdtnHoten: json['dkdtnHoten'] as String?,
      imagePath: json['imagePath'] as String?,
      dkdtnNgaysinh: json['dkdtnNgaysinh'] as String?,
      dkdtnChuyenmon: json['dkdtnChuyenmon'] as String?,
      dkdtnDienthoai: json['dkdtnDienthoai'] as String?,
      dkdtnDantoc: json['dkdtnDantoc'] as int?,
      dkdtnTongiao: json['dkdtnTongiao'] as int?,
      dkdtnHokhauthuongtru: json['dkdtnHokhauthuongtru'] as String?,
      dkdtndmNghenganhan: json['dkdtndmNghenganhan'] as int?,
      dkdtndmNghesocap: json['dkdtndmNghesocap'] as int?,
      dkdtnGhichu: json['dkdtnGhichu'] as String?,
      dkdtnhtTelephone: json['dkdtnhtTelephone'] as bool?,
      dkdtnhtEmail: json['dkdtnhtEmail'] as bool?,
      dkdtnhtAddress: json['dkdtnhtAddress'] as bool?,
      soNhaDuong: json['soNhaDuong'] as String?,
      maTinh: json['maTinh'] as String?,
      maHuyen: json['maHuyen'] as String?,
      maXa: json['maXa'] as String?,
      idDaoTao: json['idDaoTao'] as int?,
      nguyenQuan: json['nguyenQuan'] as String?,
      idTdNgoaiNgu: json['idTdNgoaiNgu'] as String?,
      chieuCao: json['chieuCao'] as String?,
      canNang: json['canNang'] as String?,
      matTrai: json['matTrai'] as String?,
      matPhai: json['matPhai'] as String?,
      muMau: json['muMau'] as String?,
      hoTenCha: json['hoTenCha'] as String?,
      hoTenMe: json['hoTenMe'] as String?,
      diaChiBaoTin: json['diaChiBaoTin'] as String?,
      dienThoaiBaoTin: json['dienThoaiBaoTin'] as String?,
      tinNhanBaoTin: json['tinNhanBaoTin'] as String?,
      soHoChieu: json['soHoChieu'] as String?,
      docThan: json['docThan'] as bool?,
      daCoGiaDinh: json['daCoGiaDinh'] as bool?,
      daLyDi: json['daLyDi'] as bool?,
      soCon: json['soCon'] as int?,
      daLamViecONuocNgoai: json['daLamViecONuocNgoai'] as String?,
      coBhtn: json['coBhtn'] as bool?,
      idtv: json['idtv'] as String?,
      dkStatus: json['dkStatus'] as int?,
      dkngonngu: json['dkngonngu'] as String?,
      duyetdangky: json['duyetdangky'] as bool?,
      dkdtndmDoituongchinhsach: json['dkdtndmDoituongchinhsach'] as int?,
      dkdtndmTruong: json['dkdtndmTruong'] as int?,
      dkdtnGioitinh: json['dkdtnGioitinh'] as int?,
      dkdtnDuyet: json['dkdtnDuyet'] as int?,
      idTrangThaiTrungTuyen: json['idTrangThaiTrungTuyen'] as bool?,
      dkdtndmTrinhdohocvanDtn: json['dkdtndmTrinhdohocvanDtn'] as int?,
      dkdtndmNghedaotao: json['dkdtndmNghedaotao'] as int?,
      dkdtndmNganhcaodang: json['dkdtndmNganhcaodang'] as int?,
      dkdtndmNganhtrungcap: json['dkdtndmNganhtrungcap'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'idloai': idloai,
      'dkdtnNgay': dkdtnNgay,
      'dkdtnUsername': dkdtnUsername,
      'dkdtnEmail': dkdtnEmail,
      'dkdtnPassword': dkdtnPassword,
      'dkdtnHoten': dkdtnHoten,
      'imagePath': imagePath,
      'dkdtnNgaysinh': dkdtnNgaysinh,
      'dkdtnChuyenmon': dkdtnChuyenmon,
      'dkdtnDienthoai': dkdtnDienthoai,
      'dkdtnDantoc': dkdtnDantoc,
      'dkdtnTongiao': dkdtnTongiao,
      'dkdtnHokhauthuongtru': dkdtnHokhauthuongtru,
      'dkdtndmNghenganhan': dkdtndmNghenganhan,
      'dkdtndmNghesocap': dkdtndmNghesocap,
      'dkdtnGhichu': dkdtnGhichu,
      'dkdtnhtTelephone': dkdtnhtTelephone,
      'dkdtnhtEmail': dkdtnhtEmail,
      'dkdtnhtAddress': dkdtnhtAddress,
      'soNhaDuong': soNhaDuong,
      'maTinh': maTinh,
      'maHuyen': maHuyen,
      'maXa': maXa,
      'idDaoTao': idDaoTao,
      'nguyenQuan': nguyenQuan,
      'idTdNgoaiNgu': idTdNgoaiNgu,
      'chieuCao': chieuCao,
      'canNang': canNang,
      'matTrai': matTrai,
      'matPhai': matPhai,
      'muMau': muMau,
      'hoTenCha': hoTenCha,
      'hoTenMe': hoTenMe,
      'diaChiBaoTin': diaChiBaoTin,
      'dienThoaiBaoTin': dienThoaiBaoTin,
      'tinNhanBaoTin': tinNhanBaoTin,
      'soHoChieu': soHoChieu,
      'docThan': docThan,
      'daCoGiaDinh': daCoGiaDinh,
      'daLyDi': daLyDi,
      'soCon': soCon,
      'daLamViecONuocNgoai': daLamViecONuocNgoai,
      'coBhtn': coBhtn,
      'idtv': idtv,
      'dkStatus': dkStatus,
      'dkngonngu': dkngonngu,
      'duyetdangky': duyetdangky,
      'dkdtndmDoituongchinhsach': dkdtndmDoituongchinhsach,
      'dkdtndmTruong': dkdtndmTruong,
      'dkdtnGioitinh': dkdtnGioitinh,
      'dkdtnDuyet': dkdtnDuyet,
      'idTrangThaiTrungTuyen': idTrangThaiTrungTuyen,
      'dkdtndmTrinhdohocvanDtn': dkdtndmTrinhdohocvanDtn,
      'dkdtndmNghedaotao': dkdtndmNghedaotao,
      'dkdtndmNganhcaodang': dkdtndmNganhcaodang,
      'dkdtndmNganhtrungcap': dkdtndmNganhtrungcap,
    };
  }

  HosoDTNModel copyWith({
    String? id,
    int? idloai,
    String? dkdtnNgay,
    String? dkdtnUsername,
    String? dkdtnEmail,
    String? dkdtnPassword,
    String? dkdtnHoten,
    String? imagePath,
    String? dkdtnNgaysinh,
    String? dkdtnChuyenmon,
    String? dkdtnDienthoai,
    int? dkdtnDantoc,
    int? dkdtnTongiao,
    String? dkdtnHokhauthuongtru,
    int? dkdtndmNghenganhan,
    int? dkdtndmNghesocap,
    String? dkdtnGhichu,
    bool? dkdtnhtTelephone,
    bool? dkdtnhtEmail,
    bool? dkdtnhtAddress,
    String? soNhaDuong,
    String? maTinh,
    String? maHuyen,
    String? maXa,
    int? idDaoTao,
    String? nguyenQuan,
    String? idTdNgoaiNgu,
    String? chieuCao,
    String? canNang,
    String? matTrai,
    String? matPhai,
    String? muMau,
    String? hoTenCha,
    String? hoTenMe,
    String? diaChiBaoTin,
    String? dienThoaiBaoTin,
    String? tinNhanBaoTin,
    String? soHoChieu,
    bool? docThan,
    bool? daCoGiaDinh,
    bool? daLyDi,
    int? soCon,
    String? daLamViecONuocNgoai,
    bool? coBhtn,
    String? idtv,
    int? dkStatus,
    String? dkngonngu,
    bool? duyetdangky,
    int? dkdtndmDoituongchinhsach,
    int? dkdtndmTruong,
    int? dkdtnGioitinh,
    int? dkdtnDuyet,
    bool? idTrangThaiTrungTuyen,
    int? dkdtndmTrinhdohocvanDtn,
    int? dkdtndmNghedaotao,
    int? dkdtndmNganhcaodang,
    int? dkdtndmNganhtrungcap,
  }) {
    return HosoDTNModel(
      id: id ?? this.id,
      idloai: idloai ?? this.idloai,
      dkdtnNgay: dkdtnNgay ?? this.dkdtnNgay,
      dkdtnUsername: dkdtnUsername ?? this.dkdtnUsername,
      dkdtnEmail: dkdtnEmail ?? this.dkdtnEmail,
      dkdtnPassword: dkdtnPassword ?? this.dkdtnPassword,
      dkdtnHoten: dkdtnHoten ?? this.dkdtnHoten,
      imagePath: imagePath ?? this.imagePath,
      dkdtnNgaysinh: dkdtnNgaysinh ?? this.dkdtnNgaysinh,
      dkdtnChuyenmon: dkdtnChuyenmon ?? this.dkdtnChuyenmon,
      dkdtnDienthoai: dkdtnDienthoai ?? this.dkdtnDienthoai,
      dkdtnDantoc: dkdtnDantoc ?? this.dkdtnDantoc,
      dkdtnTongiao: dkdtnTongiao ?? this.dkdtnTongiao,
      dkdtnHokhauthuongtru: dkdtnHokhauthuongtru ?? this.dkdtnHokhauthuongtru,
      dkdtndmNghenganhan: dkdtndmNghenganhan ?? this.dkdtndmNghenganhan,
      dkdtndmNghesocap: dkdtndmNghesocap ?? this.dkdtndmNghesocap,
      dkdtnGhichu: dkdtnGhichu ?? this.dkdtnGhichu,
      dkdtnhtTelephone: dkdtnhtTelephone ?? this.dkdtnhtTelephone,
      dkdtnhtEmail: dkdtnhtEmail ?? this.dkdtnhtEmail,
      dkdtnhtAddress: dkdtnhtAddress ?? this.dkdtnhtAddress,
      soNhaDuong: soNhaDuong ?? this.soNhaDuong,
      maTinh: maTinh ?? this.maTinh,
      maHuyen: maHuyen ?? this.maHuyen,
      maXa: maXa ?? this.maXa,
      idDaoTao: idDaoTao ?? this.idDaoTao,
      nguyenQuan: nguyenQuan ?? this.nguyenQuan,
      idTdNgoaiNgu: idTdNgoaiNgu ?? this.idTdNgoaiNgu,
      chieuCao: chieuCao ?? this.chieuCao,
      canNang: canNang ?? this.canNang,
      matTrai: matTrai ?? this.matTrai,
      matPhai: matPhai ?? this.matPhai,
      muMau: muMau ?? this.muMau,
      hoTenCha: hoTenCha ?? this.hoTenCha,
      hoTenMe: hoTenMe ?? this.hoTenMe,
      diaChiBaoTin: diaChiBaoTin ?? this.diaChiBaoTin,
      dienThoaiBaoTin: dienThoaiBaoTin ?? this.dienThoaiBaoTin,
      tinNhanBaoTin: tinNhanBaoTin ?? this.tinNhanBaoTin,
      soHoChieu: soHoChieu ?? this.soHoChieu,
      docThan: docThan ?? this.docThan,
      daCoGiaDinh: daCoGiaDinh ?? this.daCoGiaDinh,
      daLyDi: daLyDi ?? this.daLyDi,
      soCon: soCon ?? this.soCon,
      daLamViecONuocNgoai: daLamViecONuocNgoai ?? this.daLamViecONuocNgoai,
      coBhtn: coBhtn ?? this.coBhtn,
      idtv: idtv ?? this.idtv,
      dkStatus: dkStatus ?? this.dkStatus,
      dkngonngu: dkngonngu ?? this.dkngonngu,
      duyetdangky: duyetdangky ?? this.duyetdangky,
      dkdtndmDoituongchinhsach:
          dkdtndmDoituongchinhsach ?? this.dkdtndmDoituongchinhsach,
      dkdtndmTruong: dkdtndmTruong ?? this.dkdtndmTruong,
      dkdtnGioitinh: dkdtnGioitinh ?? this.dkdtnGioitinh,
      dkdtnDuyet: dkdtnDuyet ?? this.dkdtnDuyet,
      idTrangThaiTrungTuyen:
          idTrangThaiTrungTuyen ?? this.idTrangThaiTrungTuyen,
      dkdtndmTrinhdohocvanDtn:
          dkdtndmTrinhdohocvanDtn ?? this.dkdtndmTrinhdohocvanDtn,
      dkdtndmNghedaotao: dkdtndmNghedaotao ?? this.dkdtndmNghedaotao,
      dkdtndmNganhcaodang: dkdtndmNganhcaodang ?? this.dkdtndmNganhcaodang,
      dkdtndmNganhtrungcap: dkdtndmNganhtrungcap ?? this.dkdtndmNganhtrungcap,
    );
  }
}
