class LoginRequest {
  final String userName;
  final String password;
  final String userType;

  LoginRequest({
    required this.userName,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
        'userType': userType,
      };
}
