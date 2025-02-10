import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String token;

  const AuthLoggedIn(this.token);

  @override
  List<Object?> get props => [token];
}

class AuthLoggedOut extends AuthEvent {}
