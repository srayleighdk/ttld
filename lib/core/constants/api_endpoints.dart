class ApiEndpoints {
  static String get login => '/auth/login';
  static String get logout => '/auth/logout';
  static String get registerNTD => '/auth/register-NTD';
  static String get registerNTV => '/auth/register-TVL';
  static String get registerXKLD => '/auth/register-XKLD';
  static String get forgotPassword => '/auth/forgot-password';
  static String get resetPassword => '/auth/reset-password';

  //ld
  static String get ld => '/ld';
  static String get addLD => '/ld';
  static String get editLD => '/ld';
  static String get deleteLD => '/ld';

  // DSLD M03TT11
  static String get getDSNLD => '/ds-ld';
  static String get addDSNLD => '/ds-ld';
  static String get editDSNLD => '/ds-ld';
  static String get deleteDSNLD => '/ds-ld'; // Add other endpoints as needed

  // M03PLI
  static String get m03pli => '/tttt/m03pli';

  // groups
  static String get groups => '/user/group';

  static String get ntd => '/tttt/nha-td';
  static String get ntdById => '/tttt/nha-tdid';

  // Danh muc hanh chinh
  static String get hanhChinh => '/danhmuc/hanh-chinh';
  static String get tinh => '/danhmuc/hanh-chinh/tinh';
  static String get huyen => '/danhmuc/hanh-chinh/huyen';
  static String get xa => '/danhmuc/hanh-chinh/xa';
  static String get thon => '/danhmuc/hanh-chinh/thon';
  static String get tinhMoi => '/danhmuc/hanh-chinh/tinhmoi';
  static String get xaMoi => '/danhmuc/hanh-chinh/xamoi';

  static String get chucDanh => '/danhmuc/chuc-danh';

  // BHTN Khoa dao tao
  static String get bhtnKhoadaotao => '/bhtn-khoadaotao';

  // Ho so ung vien
  static String get hosoUngVien => '/nghiep-vu/hoso-uv';
  static String get hosoUngVienById => '/nghiep-vu/hoso-uvid';

  static const String sgdvl = '/nghiep-vu/tt-sangd';
}
