import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/features/auth/models/login_request.dart';
import 'package:ttld/features/auth/models/login_response.dart';
import 'package:ttld/features/auth/models/signup_request.dart';

class AuthApiService {
  final ApiClient apiClient;

  AuthApiService(this.apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await apiClient.post(ApiEndpoints.login, data: request);
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LoginResponse> signup(BaseSignupRequest request, userType) async {
    String apiEndpoint;
    switch (userType) {
      case 'ntd':
        apiEndpoint = ApiEndpoints.registerNTD;
        break;
      case 'ntv':
        apiEndpoint = ApiEndpoints.registerNTV;
        break;
      default:
        throw Exception('Invalid user type');
    }
    final response = await apiClient.post(apiEndpoint, data: request);
    return LoginResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await apiClient.post(ApiEndpoints.logout);
  }
}


