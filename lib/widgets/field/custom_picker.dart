import 'package:flutter/material.dart';

class CustomPicker<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final Color? backgroundColor;
  final String Function(T?)? displayItemBuilder;
  final Widget? label;

  const CustomPicker({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hint = 'Select an option',
    this.backgroundColor,
    this.displayItemBuilder,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.grey.shade400),
        ),
        width: double.infinity,
        child: DropdownMenu<T>(
          label: label,
          initialSelection: selectedItem,
          onSelected: onChanged,
          dropdownMenuEntries: items.map((T item) {
            return DropdownMenuEntry<T>(
              value: item,
              label: displayItemBuilder != null
                  ? displayItemBuilder!(item)
                  : item.toString(),
            );
          }).toList(),
          hintText: hint,
          width: double.infinity,
        ));
  }
}
