import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthUnauthenticated()) {
    on<AuthLoginSuccess>(_onAuthLoginSuccess);
    on<AuthLogout>(_onAuthLogout);
    on<AuthUpdateAvatar>(_onAuthUpdateAvatar);
  }

  void _onAuthLoginSuccess(
    AuthLoginSuccess event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthAuthenticated(
      token: event.token,
      userId: event.userId,
      userName: event.userName,
      isAdmin: event.isAdmin,
      userType: event.userType!,
    ));
  }

  void _onAuthUpdateAvatar(
    AuthUpdateAvatar event,
    Emitter<AuthState> emit,
  ) {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      emit(AuthAuthenticated(
        token: currentState.token,
        userId: currentState.userId,
        userName: currentState.userName,
        isAdmin: currentState.isAdmin,
        userType: currentState.userType,
        avatarUrl: event.avatarUrl,
      ));
    } else {}
  }

  Future<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    try {
      debugPrint('AuthBloc: Handling logout');

      await authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      // Handle error if needed
    }
  }
}
