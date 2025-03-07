// picker_quoc_gia.dart
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';

class PickerQuocGia extends StatefulWidget {
  final int? initialValue;
  final void Function(QuocGia?) onChanged;
  final String? hintText;
  final bool isLoading; // Pass loading state if needed

  const PickerQuocGia({
    this.initialValue,
    required this.onChanged,
    this.hintText,
    this.isLoading = false,
    super.key,
  });

  @override
  _PickerQuocGiaState createState() => _PickerQuocGiaState();
}

class _PickerQuocGiaState extends State<PickerQuocGia> {
  QuocGia? _selectedQuocGia;

  @override
  void initState() {
    super.initState();
    final quocGias = locator<List<QuocGia>>();
    if (widget.initialValue != null && quocGias.isNotEmpty) {
      _selectedQuocGia = quocGias.firstWhere(
        (quocGia) => quocGia.id == widget.initialValue,
        orElse: () => QuocGia(
            id: 0, name: '', viettat: '', displayOrder: 0, status: false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quocGias = locator<List<QuocGia>>(); // Get preloaded list
    return CustomPickerGrok<QuocGia>(
      label: const Text("Quốc gia"),
      items: quocGias,
      selectedItem: _selectedQuocGia,
      onChanged: (value) {
        setState(() {
          _selectedQuocGia = value;
        });
        widget.onChanged(value);
      },
      displayItemBuilder: (QuocGia? item) => item?.displayName ?? '',
      hint: widget.hintText ?? 'Select a country',
      isLoading: widget.isLoading ||
          quocGias.isEmpty, // Show loading if list is empty or explicitly set
      backgroundColor: Colors.white, // Example customization
    );
  }
}
