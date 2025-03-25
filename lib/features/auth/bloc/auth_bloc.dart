import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final getIt = GetIt.instance;
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
      userType: event.userType!,
    ));

    debugPrint('✅ AuthBloc: State updated to authenticated');
  }

  Future<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    try {
      debugPrint('🔓 AuthBloc: Handling logout');

      await getIt<AuthRepository>().logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      // Handle error if needed
      debugPrint('❌ AuthBloc: Error during logout: $e');
    }
  }
}
