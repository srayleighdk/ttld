import 'package:flutter/material.dart';

class CustomPickerMap<K> extends StatelessWidget {
  final Map<K, String> items;
  final K? selectedItem;
  final ValueChanged<K?> onChanged;
  final String hint;
  final Color? backgroundColor;
  final String Function(String?)? displayItemBuilder;
  final Widget? label;

  const CustomPickerMap({
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
    return DropdownMenu<K>(
      label: label,
      initialSelection: selectedItem,
      onSelected: onChanged,
      dropdownMenuEntries: items.entries
          .map((entry) => DropdownMenuEntry<K>(
                value: entry.key,
                label: displayItemBuilder != null
                    ? displayItemBuilder!(entry.value)
                    : entry.value,
                style: MenuItemButton.styleFrom(foregroundColor: Colors.black),
              ))
          .toList(),
      hintText: hint,
      menuHeight: 500,
      textStyle: const TextStyle(color: Colors.black),
      expandedInsets: EdgeInsets.zero,
    );
  }
}
