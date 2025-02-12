import 'package:ttld/helppers/validator/rules.dart';

/// Default implementation of [ValidationException] which carries a [attribute] and [validationRule].
class ValidationException implements Exception {
  /// Creates a new `ValidationException` using a [attribute] and [validationRule].
  ValidationException(this.attribute, this.validationRule);

  /// Attribute that the validation failed on.
  final String attribute;

  /// ValidationRule that the [attribute] failed on.
  final ValidationRule validationRule;

  /// Returns a description of the exception.
  @override
  String toString() =>
      'ValidationException: The "$attribute" attribute has failed validation on "${validationRule.signature}"';

  /// TextField error message.
  String toTextFieldMessage() =>
      (validationRule.textFieldMessage ?? validationRule.description);
}
