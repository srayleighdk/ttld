import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnauthenticated()) {
    on<AuthLoginSuccess>(_onAuthLoginSuccess);
    on<AuthLogout>(_onAuthLogout);
  }

  void _onAuthLoginSuccess(
    AuthLoginSuccess event,
    Emitter<AuthState> emit,
  ) {
    debugPrint('🔐 AuthBloc: Handling login success');
    debugPrint('📦 Auth data: ${event.toString()}');

    emit(AuthAuthenticated(
      token: event.token,
      userId: event.userId,
      userName: event.userName,
      isAdmin: event.isAdmin,
    ));

    debugPrint('✅ AuthBloc: State updated to authenticated');
  }

  void _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) {
    debugPrint('🔓 AuthBloc: Handling logout');
    emit(AuthUnauthenticated());
    debugPrint('✅ AuthBloc: State updated to unauthenticated');
  }
}
