import 'package:ttld/features/auth/models/user_data.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final String? refreshToken;
  final UserData? userData;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.refreshToken,
    this.userData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      refreshToken: json['refreshToken'],
      userData:
          json['userData'] != null ? UserData.fromJson(json['userData']) : null,
    );
  }
}
