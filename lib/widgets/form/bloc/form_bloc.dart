import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(const FormState(forms: {})) {
    on<SetFieldValue>(_onSetFieldValue);
    on<SetFieldOptions>(_onSetFieldOptions);
    on<RefreshForm>(_onRefreshForm);
    on<ClearForm>(_onClearForm);
  }

  /// Handle field value updates for a specific form
  void _onSetFieldValue(SetFieldValue event, Emitter<FormState> emit) {
    final updatedForms = Map<String, Map<String, dynamic>>.from(state.forms);
    updatedForms[event.formName] =
        Map<String, dynamic>.from(updatedForms[event.formName] ?? {})
          ..[event.key] = event.value;

    emit(state.copyWith(forms: updatedForms));
  }

  /// Handle field options updates for a specific form
  void _onSetFieldOptions(SetFieldOptions event, Emitter<FormState> emit) {
    final updatedForms = Map<String, Map<String, dynamic>>.from(state.forms);
    updatedForms[event.formName] =
        Map<String, dynamic>.from(updatedForms[event.formName] ?? {})
          ..[event.key] = event.options;

    emit(state.copyWith(forms: updatedForms));
  }

  /// Refresh a specific form
  void _onRefreshForm(RefreshForm event, Emitter<FormState> emit) {
    emit(state.copyWith()); // Simply trigger UI rebuild
  }

  /// Clear a specific form
  void _onClearForm(ClearForm event, Emitter<FormState> emit) {
    final updatedForms = Map<String, Map<String, dynamic>>.from(state.forms);
    updatedForms.remove(event.formName); // Remove the form from the state

    emit(state.copyWith(forms: updatedForms));
  }
}
