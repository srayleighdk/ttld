import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final String userId;
  final String userName;
  final bool isAdmin;

  const AuthAuthenticated({
    required this.token,
    required this.userId,
    required this.userName,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [token, userId, userName, isAdmin];
}

class AuthUnauthenticated extends AuthState {}
