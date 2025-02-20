import 'package:flutter/material.dart';

class CustomPicker<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
import 'package:flutter/material.dart';

class CustomPicker<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final Color? backgroundColor;
  final String Function(T?)? displayItemBuilder;

  const CustomPicker({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hint = 'Select an option',
    this.backgroundColor,
    this.displayItemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownMenu<T>(
        initialSelection: selectedItem,
        onSelected: onChanged,
        dropdownMenuEntries: items.map((T item) {
          return DropdownMenuEntry<T>(
            value: item,
            label: displayItemBuilder != null ? displayItemBuilder!(item) : item.toString(),
          );
        }).toList(),
        hintText: hint,
      ),
    );
  }
}
