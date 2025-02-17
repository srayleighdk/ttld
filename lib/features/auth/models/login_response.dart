class LoginResponse {
  final String id;
  final String name;
  final bool isAdmin;
  final String token;
  final String email;

  LoginResponse({
    required this.id,
    required this.name,
    required this.isAdmin,
    required this.token,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      token: json['token'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
