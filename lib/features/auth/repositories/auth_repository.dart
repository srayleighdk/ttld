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
      throw Exception('Tên đăng nhập hoặc mật khẩu không đúng');
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
      // Clear secure storage
      await storage.delete(key: 'token');
      
      // Clear all user-related data from SharedPreferences
      await prefs.remove('token');
      await prefs.remove('userId');
      await prefs.remove('userName');
      await prefs.remove('userType');
      await prefs.setBool('is_logged_in', false);
      await prefs.remove('login_timestamp');
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
    
    // Set login status and timestamp for session management
    await prefs.setBool('is_logged_in', true);
    await prefs.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);
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
  
  /// Check if user has a valid session
  bool hasValidSession({Duration? sessionDuration}) {
    final duration = sessionDuration ?? const Duration(hours: 24); // Default to 24 hours
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final loginTimestamp = prefs.getInt('login_timestamp') ?? 0;
    
    if (!isLoggedIn) return false;
    
    final now = DateTime.now().millisecondsSinceEpoch;
    return (now - loginTimestamp) < duration.inMilliseconds;
  }
}
