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
}
