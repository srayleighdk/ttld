import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String userName;
  final String password;
  final String userType;

  const LoginSubmitted({
    required this.userName,
    required this.password,
    this.userType = 'user',
  });

  @override
  List<Object?> get props => [userName, password, userType];
}
