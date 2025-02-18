part of 'form_bloc.dart';

class FormState extends Equatable {
  final Map<String, Map<String, dynamic>> forms; // Each form has its own fields

  const FormState({required this.forms});

  /// Copy with new values (immutability)
  FormState copyWith({Map<String, Map<String, dynamic>>? forms}) {
    return FormState(forms: forms ?? this.forms);
  }

  @override
  List<Object?> get props => [forms];
}
