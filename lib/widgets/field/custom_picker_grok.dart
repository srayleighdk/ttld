// custom_picker_grok.dart
import 'package:flutter/material.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// This class is maintained for backward compatibility.
/// New code should use ModernPicker directly.
class CustomPickerGrok<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final String Function(T?)? displayItemBuilder;
  final Widget? label;
  final String? Function(T?)? validator;
  final bool isLoading;

  const CustomPickerGrok({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hint = 'Select an option',
    this.displayItemBuilder,
    this.label,
    this.validator,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Convert items to GenericPickerItem if they aren't already
    final List<_WrappedItem<T>> wrappedItems = items.map((item) {
      if (item is GenericPickerItem) {
        return _WrappedItem<T>(
          item: item,
          id: (item as GenericPickerItem).id,
          displayName: (item as GenericPickerItem).displayName,
        );
      } else {
        return _WrappedItem<T>(
          item: item,
          id: item.hashCode,
          displayName: displayItemBuilder != null 
              ? displayItemBuilder!(item) 
              : item.toString(),
        );
      }
    }).toList();

    // Find the selected item in the wrapped items
    _WrappedItem<T>? wrappedSelectedItem;
    if (selectedItem != null) {
      wrappedSelectedItem = wrappedItems.firstWhere(
        (wrappedItem) => wrappedItem.item == selectedItem,
        orElse: () => _WrappedItem<T>(
          item: selectedItem as T, // Cast to non-nullable T since we've checked it's not null
          id: selectedItem.hashCode,
          displayName: displayItemBuilder != null 
              ? displayItemBuilder!(selectedItem) 
              : selectedItem.toString(),
        ),
      );
    }

    return ModernPicker<_WrappedItem<T>>(
      label: label != null ? (label is Text ? (label as Text).data : null) : null,
      hint: hint,
      items: wrappedItems,
      initialValue: wrappedSelectedItem?.id,
      onChanged: (value) {
        onChanged(value != null ? value.item : null);
      },
      validator: validator != null 
          ? (value) => validator!(value != null ? value.item : null) 
          : null,
      isLoading: isLoading,
      prefixIcon: label is! Text ? label : null,
    );
  }
}

/// A wrapper class to convert any type to a GenericPickerItem
class _WrappedItem<T> extends GenericPickerItem {
  final T item;

  _WrappedItem({
    required this.item,
    required dynamic id,
    required String displayName,
  }) : super(id: id, displayName: displayName);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _WrappedItem<T> && other.item == item;
  }

  @override
  int get hashCode => item.hashCode;
}