import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/login_event.dart';
import 'package:ttld/features/auth/bloc/login_state.dart';
import '../repositories/auth_repository.dart';
import '../models/login_request.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  LoginBloc({required this.authRepository, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final response = await authRepository.login(
        LoginRequest(
          userName: event.userName,
          password: event.password,
          userType: event.userType.toUpperCase(),
        ),
      );

      // Update auth state first
      authBloc.add(AuthLoginSuccess(
        token: response.token,
        userId: response.id,
        userName: response.name,
        isAdmin: response.isAdmin,
        userType: event.userType,
      ));

      // Then emit login success
      emit(LoginSuccess(
        response.id,
        event.userType,
      ));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
