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
  final String name;
  final String password;
  final String userType;
  final String confirmPassword;
  final String region;

  // Admin specific fields

  // NTD specific fields
  final String? maSoThue;

  // NTV specific fields

  const SignupSubmitted({
    required this.userName,
    required this.email,
    required this.name,
    required this.password,
    required this.userType,
    required this.confirmPassword,
    required this.region,
    this.maSoThue,
  });

  @override
  List<Object?> get props =>
      [userName, email, name, password, confirmPassword, userType, region, maSoThue];
}
