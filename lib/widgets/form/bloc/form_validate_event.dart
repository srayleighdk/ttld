part of 'form_validate_bloc.dart';

abstract class FormValidationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ValidateFormEvent extends FormValidationEvent {
  final Map<String, dynamic> rules;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? messages;
  final bool showAlert;
  final Duration? alertDuration;
  final ToastNotificationStyleType alertStyle;
  final Function()? onSuccess;
  final Function(Exception exception)? onFailure;
  final String? lockRelease;

  ValidateFormEvent({
    required this.rules,
    this.data,
    this.messages,
    this.showAlert = true,
    this.alertDuration,
    this.alertStyle = ToastNotificationStyleType.warning,
    this.onSuccess,
    this.onFailure,
    this.lockRelease,
  });

  @override
  List<Object?> get props => [
        rules,
        data,
        messages,
        showAlert,
        alertDuration,
        alertStyle,
        lockRelease
      ];
}
