part of 'form_validate_bloc.dart';

abstract class FormValidationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FormValidationInitial extends FormValidationState {}

class FormValidating extends FormValidationState {}

class FormValidationSuccess extends FormValidationState {}

class FormValidationError extends FormValidationState {
  final Exception exception;
  FormValidationError({required this.exception});
  @override
  List<Object?> get props => [exception];
}
