import 'package:flutter/material.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';

class GenericPickerItem {
  final dynamic id;
  final String displayName;

  const GenericPickerItem({
    required this.id,
    required this.displayName,
  });
}

class GenericPicker<T extends GenericPickerItem> extends StatefulWidget {
  final dynamic initialValue;
  final void Function(T?) onChanged;
  final String? hintText;
  final bool isLoading;
  final String label;
  final List<T> items;

  const GenericPicker({
    this.initialValue,
    required this.onChanged,
    required this.label,
    required this.items,
    this.hintText,
    this.isLoading = false,
    super.key,
  });

  @override
  GenericPickerState<T> createState() => GenericPickerState<T>();
}

class GenericPickerState<T extends GenericPickerItem> extends State<GenericPicker<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.items.isNotEmpty) {
      _selectedItem = widget.items.firstWhere(
        (item) => item.id == widget.initialValue,
        orElse: () => widget.items.first,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPickerGrok<T>(
      label: Text(widget.label),
      items: widget.items,
      selectedItem: _selectedItem,
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
        });
        widget.onChanged(value);
      },
      displayItemBuilder: (T? item) => item?.displayName ?? '',
      hint: widget.hintText ?? 'Select an item',
      isLoading: widget.isLoading,
    );
  }
}
