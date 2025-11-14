import 'package:flutter/material.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// A multi-select dropdown that allows selecting multiple items
/// and stores them as comma-separated text
class MultiSelectDropdown<T extends GenericPickerItem> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MultiSelectDropdown({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<MultiSelectDropdown<T>> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T extends GenericPickerItem>
    extends State<MultiSelectDropdown<T>> {
  List<T> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _parseInitialValue();
  }

  void _parseInitialValue() {
    if (widget.controller.text.isNotEmpty) {
      final textValues = widget.controller.text.split(',').map((e) => e.trim()).toList();
      _selectedItems = widget.items
          .where((item) => textValues.contains(item.displayName))
          .toList();
    }
  }

  void _showMultiSelectDialog() async {
    final List<T>? results = await showDialog<List<T>>(
      context: context,
      builder: (BuildContext context) {
        return _MultiSelectDialog<T>(
          items: widget.items,
          initialSelectedItems: _selectedItems,
          title: widget.labelText,
        );
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
        widget.controller.text =
            _selectedItems.map((item) => item.displayName).join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        InkWell(
          onTap: _showMultiSelectDialog,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.surface,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.controller.text.isEmpty
                        ? widget.hintText
                        : widget.controller.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: widget.controller.text.isEmpty
                          ? theme.colorScheme.onSurfaceVariant.withOpacity(0.6)
                          : theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MultiSelectDialog<T extends GenericPickerItem> extends StatefulWidget {
  final List<T> items;
  final List<T> initialSelectedItems;
  final String title;

  const _MultiSelectDialog({
    required this.items,
    required this.initialSelectedItems,
    required this.title,
  });

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T extends GenericPickerItem>
    extends State<_MultiSelectDialog<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelectedItems);
  }

  void _toggleItem(T item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final isSelected = _selectedItems.contains(item);

            return CheckboxListTile(
              value: isSelected,
              title: Text(item.displayName),
              onChanged: (bool? value) {
                _toggleItem(item);
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _selectedItems),
          child: const Text('Chọn'),
        ),
      ],
    );
  }
}
