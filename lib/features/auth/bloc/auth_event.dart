import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthAppStarted extends AuthEvent {}

class AuthLoginSuccess extends AuthEvent {
  final String token;
  final String userId;
  final String userName;
  final bool isAdmin;
  final String? userType;

  AuthLoginSuccess(
      {required this.token,
      required this.userId,
      required this.userName,
      required this.isAdmin,
      this.userType});

  @override
  List<Object?> get props => [token, userId, userName, isAdmin, userType];
}

class AuthLogout extends AuthEvent {}

class AuthUpdateAvatar extends AuthEvent {
  final String avatarUrl;

  AuthUpdateAvatar(this.avatarUrl);

  @override
  List<Object?> get props => [avatarUrl];
}
