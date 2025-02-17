import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final Dio dio;

  ForgotPasswordBloc(this.dio) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await dio.post(
        'https://your-api.com/auth/forgot-password',
        data: {'email': event.email},
      );

      if (response.statusCode == 200) {
        emit(ForgotPasswordSuccess(response.data['message']));
      } else {
        emit(ForgotPasswordFailure('Something went wrong!'));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
