import 'package:ttld/helppers/help.dart';

class ApiEndpoints {
  static final String baseUrl = getEnv('API_BASE_URL');
  static String ld = '/ld';
  // DSLD M03TT11
  static String getDSNLD = '$baseUrl/ds-ld';
  static String addDSNLD = '$baseUrl/ds-ld';
  static String editDSNLD = '$baseUrl/ds-ld';
  static String deleteDSNLD = '$baseUrl/ds-ld'; // Add other endpoints as needed

  // groups
  static String groups = '$baseUrl/user/group';

  static String ntd = '$baseUrl/tttt/nha-td';
  static String ntdById = '$baseUrl/tttt/nha-tdid';

  // Danh muc hanh chinh
  static String tinh = '$baseUrl/api/danhmuc/hanh-chinh/tinh';
  static String huyen = '$baseUrl/api/danhmuc/hanh-chinh/huyen';
  static String xa = '$baseUrl/api/danhmuc/hanh-chinh/xa';
  static String thon = '$baseUrl/api/danhmuc/hanh-chinh/thon';
}
