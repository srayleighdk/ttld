abstract class BaseSignupRequest {
  final String userName;
  final String email;
  final String password;
  final String userType;

  BaseSignupRequest({
    required this.userName,
    required this.email,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toJson();
}

class AdminSignupRequest extends BaseSignupRequest {
  final String adminCode; // Special code for admin registration

  AdminSignupRequest({
    required super.userName,
    required super.email,
    required super.password,
    required this.adminCode,
  }) : super(userType: 'ADMIN');

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'password': password,
        'userType': userType,
        'adminCode': adminCode,
      };
}

class NTDSignupRequest extends BaseSignupRequest {
  final String companyName;
  final String companyAddress;
  final String businessLicense;

  NTDSignupRequest({
    required super.userName,
    required super.email,
    required super.password,
    required this.companyName,
    required this.companyAddress,
    required this.businessLicense,
  }) : super(userType: 'NTD');

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'password': password,
        'userType': userType,
        'companyName': companyName,
        'companyAddress': companyAddress,
        'businessLicense': businessLicense,
      };
}

class NTVSignupRequest extends BaseSignupRequest {
  final String fullName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;

  NTVSignupRequest({
    required super.userName,
    required super.email,
    required super.password,
    required this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
  }) : super(userType: 'NTV');

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'password': password,
        'userType': userType,
        'fullName': fullName,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (dateOfBirth != null)
          'dateOfBirth': dateOfBirth!.toIso8601String(),
      };
}
