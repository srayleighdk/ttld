import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/core/utils/toast_enums.dart';
import 'package:ttld/helppers/validator/validator.dart';

part 'form_validate_event.dart';
part 'form_validate_state.dart';

class FormValidationBloc
    extends Bloc<FormValidationEvent, FormValidationState> {
  FormValidationBloc() : super(FormValidationInitial()) {
    on<ValidateFormEvent>((event, emit) async {
      emit(FormValidating());

      try {
        Map<String, String> finalRules = {};
        Map<String, dynamic> finalData = {};
        Map<String, dynamic> finalMessages = event.messages ?? {};

        bool completed = false;
        for (MapEntry rule in event.rules.entries) {
          // ... (Validation rule processing logic - same as before)
        }

        if (completed) return;

        if (event.data != null) {
          event.data!.forEach((key, value) {
            finalData.addAll({key: value});
          });
        }

        // ... (Lock release logic - same as before, but using emit)

        try {
          await NyValidator.check(
            // Assuming NyValidator.check is asynchronous
            rules: finalRules,
            data: finalData,
            messages: finalMessages,
            // context: context, // You need to provide context here
            showAlert: event.showAlert,
            alertDuration: event.alertDuration,
            alertStyle: event.alertStyle,
          );

          emit(FormValidationSuccess());
          event.onSuccess?.call();
        } on Exception catch (exception) {
          emit(FormValidationError(exception: exception));
          event.onFailure?.call(exception);
        }
      } catch (e) {
        emit(FormValidationError(exception: Exception(e.toString())));
        event.onFailure?.call(Exception(e.toString()));
      }
    });
  }
}
