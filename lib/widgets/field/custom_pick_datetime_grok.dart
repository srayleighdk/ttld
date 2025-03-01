import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPickDateTimeGrok extends StatefulWidget {
  const CustomPickDateTimeGrok({
    Key? key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.selectedDate,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final DateTime? selectedDate;
  final String? Function(DateTime?)? validator;
  final dynamic initialValue;

  @override
  State<CustomPickDateTimeGrok> createState() => _CustomPickDateTimeGrokState();
}

class _CustomPickDateTimeGrokState extends State<CustomPickDateTimeGrok> {
  DateTime? _selectedDate;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedDate =
        _parseInitialValue(widget.initialValue) ?? widget.selectedDate;
  }

  // Parse initial value from backend with support for backend formats
  DateTime? _parseInitialValue(dynamic value) {
    if (value == null) {
      print("initialValue is null");
      return null;
    }
    if (value is DateTime) {
      print("initialValue is DateTime: $value");
      return _validateDateRange(value);
    }
    if (value is String) {
      print("Parsing initialValue: '$value'");
      try {
        // Try full ISO 8601 first (e.g., "2025-02-27T19:55:42.000Z")
        final parsedIso = DateTime.parse(value);
        print("Parsed ISO 8601: $parsedIso");
        return _validateDateRange(parsedIso);
      } catch (e) {
        print("ISO 8601 parse failed: $e");
        try {
          // Try YYYY-MM-DD (e.g., "2025-02-28")
          final ymdFormat = DateFormat('yyyy-MM-dd');
          final parsedYmd = ymdFormat.parse(value);
          print("Parsed YYYY-MM-DD: $parsedYmd");
          return _validateDateRange(parsedYmd);
        } catch (e) {
          print("YYYY-MM-DD parse failed: $e");
          try {
            // Try DD-MM-YYYY (e.g., "28-02-2025")
            final dmyFormat = DateFormat('dd-MM-yyyy');
            final parsedDmy = dmyFormat.parse(value);
            print("Parsed DD-MM-YYYY: $parsedDmy");
            return _validateDateRange(parsedDmy);
          } catch (e) {
            print("DD-MM-YYYY parse failed: $e");
            try {
              // Try ISO without Z (e.g., "2010-02-27T00:00:00.000")
              final isoNoZFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
              final parsedIsoNoZ = isoNoZFormat.parse(value, true);
              print("Parsed ISO without Z: $parsedIsoNoZ");
              return _validateDateRange(parsedIsoNoZ);
            } catch (e) {
              print("ISO without Z parse failed: $e");
              return null; // Fallback to null
            }
          }
        }
      }
    }
    print("Unsupported initialValue type: $value");
    return null;
  }

  // Validate date is within picker range
  DateTime? _validateDateRange(DateTime parsed) {
    final firstDate = DateTime(1900);
    final lastDate = DateTime(2100);
    if (parsed.isBefore(firstDate) || parsed.isAfter(lastDate)) {
      print("Parsed date $parsed is out of range ($firstDate to $lastDate)");
      return null; // Out of range, fallback to null
    }
    return parsed;
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      widget.onChanged?.call(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectYear(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.hintText ?? 'Select Date',
              border: const OutlineInputBorder(),
              errorText: _errorText,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                      : widget.hintText ?? 'Select Date',
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String? validate() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_selectedDate);
      });
      return _errorText;
    }
    return null;
  }
}
