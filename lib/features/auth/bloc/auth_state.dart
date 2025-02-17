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
  final int? idPhieu;
  final String? avatarUrl;
  final String? userType;

  const AuthAuthenticated(
      {required this.token,
      required this.userId,
      required this.userName,
      required this.isAdmin,
      this.idPhieu,
      this.avatarUrl,
      this.userType});

  @override
  List<Object?> get props =>
      [token, userId, userName, isAdmin, idPhieu, avatarUrl, userType];
}

class AuthUnauthenticated extends AuthState {}
