import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginSuccess extends AuthEvent {
  final String token;
  final String userId;
  final String userName;
  final bool isAdmin;

  AuthLoginSuccess({
    required this.token,
    required this.userId,
    required this.userName,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [token, userId, userName, isAdmin];
}

class AuthLogout extends AuthEvent {}
