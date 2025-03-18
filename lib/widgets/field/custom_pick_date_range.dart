import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  final String labelText;
  final DateTime? initialFromDate;
  final DateTime? initialToDate;
  final ValueChanged<DateTime?>? onFromDateChanged;
  final ValueChanged<DateTime?>? onToDateChanged;
  final FormFieldValidator<String>? validator;

  const CustomDateRangePicker({
    super.key,
    required this.labelText,
    this.initialFromDate,
    this.initialToDate,
    this.onFromDateChanged,
    this.onToDateChanged,
    this.validator,
  });

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late TextEditingController _fromController;
  late TextEditingController _toController;
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _fromDate = widget.initialFromDate;
    _toDate = widget.initialToDate;
    _fromController = TextEditingController(
        text: _fromDate != null ? DateFormat('dd/MM/yyyy').format(_fromDate!) : '');
    _toController = TextEditingController(
        text: _toDate != null ? DateFormat('dd/MM/yyyy').format(_toDate!) : '');
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate ?? DateTime.now() : _toDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromController.text = DateFormat('dd/MM/yyyy').format(picked);
          widget.onFromDateChanged?.call(picked);
        } else {
          _toDate = picked;
          _toController.text = DateFormat('dd/MM/yyyy').format(picked);
          widget.onToDateChanged?.call(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _fromController,
              decoration: InputDecoration(
                labelText: '${widget.labelText} (Từ ngày)',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, true),
                ),
              ),
              readOnly: true,
              validator: widget.validator,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: '${widget.labelText} (Đến ngày)',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, false),
                ),
              ),
              readOnly: true,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
