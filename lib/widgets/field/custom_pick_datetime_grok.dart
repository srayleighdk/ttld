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
  final ValueChanged<String?>? onChanged; // Keep as String? for ISO 8601
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

  DateTime? _parseInitialValue(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return _validateDateRange(value);
    if (value is String) {
      try {
        final parsedIso = DateTime.parse(value);
        return _validateDateRange(parsedIso);
      } catch (e) {
        try {
          final ymdFormat = DateFormat('yyyy-MM-dd');
          final parsedYmd = ymdFormat.parse(value);
          return _validateDateRange(parsedYmd);
        } catch (e) {
          try {
            final dmyFormat = DateFormat('dd-MM-yyyy');
            final parsedDmy = dmyFormat.parse(value);
            return _validateDateRange(parsedDmy);
          } catch (e) {
            return null;
          }
        }
      }
    }
    return null;
  }

  DateTime? _validateDateRange(DateTime parsed) {
    final firstDate = DateTime(1900);
    final lastDate = DateTime(2100);
    if (parsed.isBefore(firstDate) || parsed.isAfter(lastDate)) return null;
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
      final normalizedDate = DateTime.utc(picked.year, picked.month, picked.day);
      setState(() {
        _selectedDate = normalizedDate;
      });
      final isoDate = normalizedDate.toIso8601String();
      print("Sending ISO 8601: '$isoDate'");
      widget.onChanged?.call(isoDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(widget.labelText!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      ? DateFormat('dd-MM-yyyy').format(_selectedDate!.toLocal())
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
