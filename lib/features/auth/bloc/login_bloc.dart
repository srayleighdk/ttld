import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/bloc/login_event.dart';
import 'package:ttld/features/auth/bloc/login_state.dart';
import '../repositories/auth_repository.dart';
import '../models/login_request.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
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
          userType: event.userType, // or get from event if needed
        ),
      );

      emit(LoginSuccess(
        token: response.token,
        userName: response.name,
        isAdmin: response.isAdmin,
        userId: response.id,
      ));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
