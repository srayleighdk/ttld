part of 'form_bloc.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();
  @override
  List<Object?> get props => [];
}

class ClearField extends FormEvent {
  final String key;
  const ClearField(this.key);
}

class SetFormData extends FormEvent {
  final Map<String, dynamic> data;
  const SetFormData(this.data);
}

/// Set a field value for a specific form
class SetFieldValue extends FormEvent {
  final String formName;
  final String key;
  final dynamic value;

  const SetFieldValue(this.formName, this.key, this.value);

  @override
  List<Object?> get props => [formName, key, value];
}

/// Set options for a field
class SetFieldOptions extends FormEvent {
  final String formName;
  final String key;
  final dynamic options;

  const SetFieldOptions(this.formName, this.key, this.options);

  @override
  List<Object?> get props => [formName, key, options];
}

/// Refresh a specific form
class RefreshForm extends FormEvent {
  final String formName;

  const RefreshForm(this.formName);

  @override
  List<Object?> get props => [formName];
}

/// Clear all data for a specific form
class ClearForm extends FormEvent {
  final String formName;

  const ClearForm(this.formName);

  @override
  List<Object?> get props => [formName];
}
