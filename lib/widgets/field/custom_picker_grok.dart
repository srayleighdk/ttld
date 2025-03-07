// custom_picker.dart
import 'package:flutter/material.dart';

class CustomPickerGrok<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final Color? backgroundColor;
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
    this.backgroundColor,
    this.displayItemBuilder,
    this.label,
    this.validator,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'CustomPickerGrok build: label=${(label as Text?)?.data}, items=${items.map((e) => (e as dynamic).id)}, selected=${(selectedItem as dynamic)?.id}');
    return FormField<T>(
      validator: validator,
      initialValue: selectedItem,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              child: DropdownMenu<T>(
                key: ValueKey(
                    '${items.length}_${selectedItem?.hashCode}'), // Force rebuild when items or selectedItem changes
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
                width: double.infinity,
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
        );
      },
    );
  }
}
