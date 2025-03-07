import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/core/services/auth_api_service.dart';
import 'package:ttld/features/auth/models/login_request.dart';
import 'package:ttld/features/auth/models/login_response.dart';
import 'package:ttld/features/auth/models/signup_request.dart';

class AuthRepository {
  final AuthApiService authApiService;
  final FlutterSecureStorage storage;
  final SharedPreferences prefs;

  AuthRepository({
    required this.authApiService,
    required this.prefs,
    required this.storage,
  });

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await authApiService.login(request);
      String userType = request.userType;
      await saveTokenToStorage(response.token);
      await saveUserDataToPrefs(response, userType);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<LoginResponse> signup(BaseSignupRequest request, userType) async {
    try {
      final response = await authApiService.signup(request, userType);
      return response;
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }

  Future<void> logout() async {
    try {
      await authApiService.logout();
      await storage.delete(key: 'token');
      await prefs.remove('token');
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  Future<void> saveUserDataToPrefs(
      LoginResponse response, String userType) async {
    await prefs.setString('token', response.token);
    await prefs.setString('userId', response.id.toString());
    await prefs.setString('userName', response.name);
    await prefs.setString('userType', userType);
  }

  bool isAdmin() {
    final userType = prefs.getString('userType');
    return userType == 'ADMIN';
  }

  bool isNTD() {
    final userType = prefs.getString('userType');
    return userType == 'NTD';
  }

  bool isNTV() {
    final userType = prefs.getString('userType');
    return userType == 'NTV';
  }

  getUserId() {
    return prefs.getString('userId');
  }

  Future<void> saveTokenToStorage(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String> getTokenFromStorage() async {
    return await storage.read(key: 'token') ?? '';
  }
}
