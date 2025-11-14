import 'package:freezed_annotation/freezed_annotation.dart';

/// Converter to handle SQL Server bit type (0/1) to Dart bool
class IntToBoolConverter implements JsonConverter<bool?, dynamic> {
  const IntToBoolConverter();

  @override
  bool? fromJson(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      if (value == '1' || value.toLowerCase() == 'true') return true;
      if (value == '0' || value.toLowerCase() == 'false') return false;
    }
    return null;
  }

  @override
  dynamic toJson(bool? value) {
    if (value == null) return null;
    return value;
  }
}
