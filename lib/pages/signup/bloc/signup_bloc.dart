import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/models/signup_request.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/pages/signup/bloc/signup_event.dart';
import 'package:ttld/pages/signup/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    try {
      BaseSignupRequest request;
      print(event.userType);

      // Create appropriate request based on user type
      switch (event.userType) {
        case 'ADMIN':
          request = AdminSignupRequest(
            userName: event.userName,
            email: event.email,
            name: event.name,
            password: event.password,
          );
          break;

        case 'ntd':
          request = NTDSignupRequest(
            userName: event.userName,
            maSoThue: event.maSoThue ?? '',
            email: event.email,
            name: event.name,
            password: event.password,
          );
          break;

        case 'ntv':
          request = NTVSignupRequest(
            userName: event.userName,
            email: event.email,
            name: event.name,
            password: event.password,
          );
          break;

        default:
          emit(const SignupFailure('Invalid user type'));
          return;
      }

      final response = await authRepository.signup(request, event.userType);

      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
