abstract class BaseSignupRequest {
  final String userName;
  final String email;
  final String name;
  final String password;
  late String userType;

  BaseSignupRequest({
    required this.userName,
    required this.email,
    required this.name,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toJson();
}

class AdminSignupRequest extends BaseSignupRequest {
  AdminSignupRequest({
    required super.userName,
    required super.email,
    required super.name,
    required super.password,
  }) : super(userType: 'ADMIN');

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'name': name,
        'password': password,
        'userType': userType,
      };
}

class NTDSignupRequest extends BaseSignupRequest {
  final String maSoThue;

  NTDSignupRequest({
    required super.userName,
    required super.email,
    required super.name,
    required super.password,
    required this.maSoThue,
  }) : super(userType: 'NTD');

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'password': password,
        'userType': userType,
        'maSoThue': maSoThue,
      };
}

class NTVSignupRequest extends BaseSignupRequest {
  NTVSignupRequest({
    required super.userName,
    required super.email,
    required super.name,
    required super.password,
  }) : super(userType: 'NTV');

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'name': name,
        'password': password,
        'userType': userType,
      };
}
