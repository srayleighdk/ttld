import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Check if user is logged in (e.g., check for stored token)
    final token = await _getStoredToken();
    if (token != null) {
      emit(AuthAuthenticated(token));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLoggedIn(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    // Store token and emit authenticated state
    await _storeToken(event.token);
    emit(AuthAuthenticated(event.token));
  }

  Future<void> _onAuthLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    // Clear stored token and emit unauthenticated state
    await _clearToken();
    emit(AuthUnauthenticated());
  }

  Future<String?> _getStoredToken() async {
    // Implement token storage retrieval
    return null;
  }

  Future<void> _storeToken(String token) async {
    // Implement token storage
  }

  Future<void> _clearToken() async {
    // Implement token removal
  }
}
