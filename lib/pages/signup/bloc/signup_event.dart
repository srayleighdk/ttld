//Events
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String userName;
  final String email;
  final String password;
  final String userType;
  final String confirmPassword;

  // Admin specific fields
  final String? adminCode;

  // NTD specific fields
  final String? companyName;
  final String? companyAddress;
  final String? businessLicense;

  // NTV specific fields
  final String? fullName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;

  const SignupSubmitted({
    required this.userName,
    required this.email,
    required this.password,
    required this.userType,
    required this.confirmPassword,
    this.adminCode,
    this.companyName,
    this.companyAddress,
    this.businessLicense,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
        confirmPassword,
        userType,
        adminCode,
        companyName,
        companyAddress,
        businessLicense,
        fullName,
        phoneNumber,
        dateOfBirth,
      ];
}
