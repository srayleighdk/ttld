import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final Dio dio;

  ChangePasswordBloc(this.dio) : super(ChangePasswordInitial()) {
    on<ChangePasswordRequested>(_onChangePasswordRequested);
  }

  Future<void> _onChangePasswordRequested(
    ChangePasswordRequested event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());
    try {
      final response = await dio.post(
        'https://your-api.com/auth/change-password',
        data: {
          'oldPassword': event.oldPassword,
          'newPassword': event.newPassword,
        },
      );

      if (response.statusCode == 200) {
        emit(ChangePasswordSuccess(response.data['message']));
      } else {
        emit(ChangePasswordFailure('Password change failed!'));
      }
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }
}
