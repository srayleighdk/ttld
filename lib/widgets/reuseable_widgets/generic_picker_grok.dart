import 'package:flutter/material.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

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
  _GenericPickerState<T> createState() => _GenericPickerState<T>();
}

class _GenericPickerState<T extends GenericPickerItem>
    extends State<GenericPicker<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _updateSelectedItem();
  }

  @override
  void didUpdateWidget(GenericPicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger update if items or initialValue changes
    if (oldWidget.items != widget.items ||
        oldWidget.initialValue != widget.initialValue) {
      _updateSelectedItem();
    }
  }

  void _updateSelectedItem() {
    print(
        'Updating selected item: label=${widget.label}, initialValue=${widget.initialValue}, items=${widget.items.map((e) => e.id).toList()}, oldSelected=${_selectedItem?.id}');

    // If items is empty or null, reset selectedItem
    if (widget.items.isEmpty) {
      _selectedItem = null;
      print('Selected item reset to null: items is empty');
      return;
    }

    // Check if the current selectedItem is still valid in the new items list
    if (_selectedItem != null &&
        !widget.items.any((item) => item.id == _selectedItem!.id)) {
      _selectedItem = null;
      print('Selected item reset to null: old selectedItem not in new items');
    }

    // Apply initialValue if provided and valid
    if (widget.initialValue != null) {
      _selectedItem = widget.items.cast<T?>().firstWhere(
            (item) => item?.id == widget.initialValue,
            orElse: () => null,
          ) as T?;
      if (_selectedItem != null) {
        print(
            'Selected item set to initialValue: id=${_selectedItem?.id}, displayName=${_selectedItem?.displayName}');
      } else {
        print(
            'No match for initialValue=${widget.initialValue} in items, selectedItem remains null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'GenericPicker build: label=${widget.label}, items=${widget.items.map((e) => e.id).toList()}, initialValue=${widget.initialValue}, selected=${_selectedItem?.id}');
    return CustomPickerGrok<T>(
      label: Text(widget.label),
      items: widget.items,
      selectedItem: _selectedItem,
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
          print('Picker onChanged: new value=${value?.id}');
        });
        widget.onChanged(value);
      },
      displayItemBuilder: (T? item) => item?.displayName ?? '',
      hint: widget.items.isEmpty
          ? 'No items available'
          : (widget.hintText ?? 'Select an item'),
      isLoading: widget.isLoading,
      backgroundColor: Colors.white,
    );
  }
}
