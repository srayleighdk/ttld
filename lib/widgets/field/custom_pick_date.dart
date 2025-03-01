import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPickDateTime extends StatefulWidget {
  const CustomPickDateTime({
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
  final ValueChanged<DateTime?>? onChanged;
  final DateTime? selectedDate;
  final String? Function(DateTime?)? validator;
  final DateTime? initialValue;

  @override
  State<CustomPickDateTime> createState() => _CustomPickDateTimeState();
}

class _CustomPickDateTimeState extends State<CustomPickDateTime> {
  DateTime? _selectedDate;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue ?? widget.selectedDate;
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
      widget.onChanged?.call(picked);
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
                      ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
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
