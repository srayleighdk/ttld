import 'package:equatable/equatable.dart';
import 'package:ttld/features/auth/models/user_data.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final UserData? userData;

  const LoginSuccess({
    required this.token,
    this.userData,
  });

  @override
  List<Object?> get props => [token, userData];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
