import 'package:ttld/helppers/help.dart';

class ApiEndpoints {
  static final String baseUrl = getEnv('API_BASE_URL');

  // Auth
  static String login = '$baseUrl/auth/login';
  static String logout = '$baseUrl/auth/logout';
  static String registerNTD = '$baseUrl/auth/register-NTD';
  static String registerNTV = '$baseUrl/auth/register-TVL';
  static String registerXKLD = '$baseUrl/auth/register-XKLD';
  static String forgotPassword = '$baseUrl/auth/forgot-password';
  static String resetPassword = '$baseUrl/auth/reset-password';

  //ld
  static String ld = '$baseUrl/ld';
  static String addLD = '$baseUrl/ld';
  static String editLD = '$baseUrl/ld';
  static String deleteLD = '$baseUrl/ld';

  // DSLD M03TT11
  static String getDSNLD = '$baseUrl/ds-ld';
  static String addDSNLD = '$baseUrl/ds-ld';
  static String editDSNLD = '$baseUrl/ds-ld';
  static String deleteDSNLD = '$baseUrl/ds-ld'; // Add other endpoints as needed

  // M03PLI
  static String m03pli = '$baseUrl/tttt/m03pli';

  // groups
  static String groups = '$baseUrl/user/group';

  static String ntd = '$baseUrl/tttt/nha-td';
  static String ntdById = '$baseUrl/tttt/nha-tdid';

  // Danh muc hanh chinh
  static String tinh = '$baseUrl/danhmuc/hanh-chinh/tinh';
  static String huyen = '$baseUrl/danhmuc/hanh-chinh/huyen';
  static String xa = '$baseUrl/danhmuc/hanh-chinh/xa';
  static String thon = '$baseUrl/danhmuc/hanh-chinh/thon';

  static String chucDanh = '$baseUrl/danhmuc/chuc-danh';

  // Ho so ung vien
  static String hosoUngVien = '$baseUrl/nghiep-vu/hoso-uv';
  static String hosoUngVienById = '$baseUrl/nghiep-vu/hoso-uvid';
}
