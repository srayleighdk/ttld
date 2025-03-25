// custom_picker.dart
import 'package:flutter/material.dart';

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
    return FormField<T>(
      validator: validator,
      initialValue: selectedItem,
      builder: (FormFieldState<T> state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownMenu<T>(
                key: ValueKey('${items.length}_${selectedItem?.hashCode}'),
                label: label,
                initialSelection: selectedItem,
                onSelected: (T? value) {
                  onChanged(value);
                  state.didChange(value);
                },
                dropdownMenuEntries: items.map((T item) {
                  return DropdownMenuEntry<T>(
                    value: item,
                    label: displayItemBuilder != null
                        ? displayItemBuilder!(item)
                        : item.toString(),
                  );
                }).toList(),
                hintText: hint,
                expandedInsets: EdgeInsets.zero,
                menuHeight: 500,
                trailingIcon: isLoading
                    ? SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey),
                        ),
                      )
                    : null,
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    state.errorText ?? '',
                    style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
