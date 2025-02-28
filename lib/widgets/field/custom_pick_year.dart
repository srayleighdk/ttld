import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPickYear extends StatefulWidget {
  const CustomPickYear({
    Key? key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.selectedDate,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime? selectedDate;

  @override
  State<CustomPickYear> createState() => _CustomPickYearState();
}

class _CustomPickYearState extends State<CustomPickYear> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
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
              labelText: widget.hintText ?? 'Select Year',
              border: const OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate != null
                      ? DateFormat('yyyy').format(_selectedDate!)
                      : widget.hintText ?? 'Select Year',
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
}
