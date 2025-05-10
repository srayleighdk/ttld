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
    on<AuthUpdateAvatar>(_onAuthUpdateAvatar);
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

  void _onAuthUpdateAvatar(
    AuthUpdateAvatar event,
    Emitter<AuthState> emit,
  ) {
    debugPrint('🖼️ AuthBloc: Updating avatar');
    debugPrint('🖼️ AuthBloc: Received avatar URL: ${event.avatarUrl}');
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      debugPrint('🖼️ AuthBloc: Current state before update: ${currentState.avatarUrl}');
      emit(AuthAuthenticated(
        token: currentState.token,
        userId: currentState.userId,
        userName: currentState.userName,
        isAdmin: currentState.isAdmin,
        userType: currentState.userType,
        avatarUrl: event.avatarUrl,
      ));
      debugPrint('🖼️ AuthBloc: New state after update: ${(state as AuthAuthenticated).avatarUrl}');
    } else {
      debugPrint('❌ AuthBloc: Cannot update avatar - not authenticated');
    }
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
