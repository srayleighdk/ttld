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

      // Create appropriate request based on user type
      switch (event.userType) {
        case 'ADMIN':
          request = AdminSignupRequest(
            userName: event.userName,
            email: event.email,
            password: event.password,
            adminCode: event.adminCode ?? '',
          );
          break;

        case 'NTD':
          request = NTDSignupRequest(
            userName: event.userName,
            email: event.email,
            password: event.password,
            companyName: event.companyName ?? '',
            companyAddress: event.companyAddress ?? '',
            businessLicense: event.businessLicense ?? '',
          );
          break;

        case 'NTV':
          request = NTVSignupRequest(
            userName: event.userName,
            email: event.email,
            password: event.password,
            fullName: event.fullName ?? '',
            phoneNumber: event.phoneNumber,
            dateOfBirth: event.dateOfBirth,
          );
          break;

        default:
          emit(const SignupFailure('Invalid user type'));
          return;
      }

      await authRepository.signup(request);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
