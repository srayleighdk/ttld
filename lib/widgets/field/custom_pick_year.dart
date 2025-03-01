import 'package:flutter/material.dart';

class CustomYearPicker extends StatefulWidget {
  const CustomYearPicker({
    super.key,
    required this.onChanged,
    this.selectedItem,
    this.minYear = 1900,
    this.maxYear,
    this.hint = 'Chọn Năm',
    this.backgroundColor,
    this.label,
  });

  final ValueChanged<int?> onChanged;
  final int? selectedItem;
  final int minYear;
  final int? maxYear;
  final String hint;
  final Color? backgroundColor;
  final Widget? label;

  @override
  State<CustomYearPicker> createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  late int? _selectedYear;
  late int _effectiveMaxYear;

  @override
  void initState() {
    super.initState();
    _effectiveMaxYear = widget.maxYear ?? DateTime.now().year;
    _selectedYear = widget.selectedItem ?? _effectiveMaxYear;
  }

  @override
  void didUpdateWidget(covariant CustomYearPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      _selectedYear = widget.selectedItem ?? _effectiveMaxYear;
    }
    if (widget.maxYear != oldWidget.maxYear) {
      _effectiveMaxYear = widget.maxYear ?? DateTime.now().year;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: DropdownMenu<int>(
        label: widget.label,
        initialSelection: _selectedYear,
        onSelected: (int? newValue) {
          setState(() {
            _selectedYear = newValue;
          });
          widget.onChanged(newValue);
        },
        dropdownMenuEntries: _generateYearEntries(),
        hintText: widget.hint,
        width: double.infinity,
        textStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  List<DropdownMenuEntry<int>> _generateYearEntries() {
    final years = List.generate(
      _effectiveMaxYear - widget.minYear + 1,
      (index) => widget.minYear + index,
    ).reversed.toList();

    return years.map((year) {
      return DropdownMenuEntry<int>(
        value: year,
        label: year.toString(),
        style: MenuItemButton.styleFrom(
          foregroundColor: Colors.black, // Ensures text is visible
        ),
      );
    }).toList();
  }
}
