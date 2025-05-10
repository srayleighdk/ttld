import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/kcn/kcn_model.dart';

class KCNPicker extends StatefulWidget {
  final String? initialTinhThanhId;
  final int? initialKCNId;
  final Function(TinhThanhModel?)? onTinhThanhChanged;
  final Function(KCNModel?)? onKCNChanged;

  const KCNPicker({
    super.key,
    this.initialTinhThanhId,
    this.initialKCNId,
    this.onTinhThanhChanged,
    this.onKCNChanged,
  });

  @override
  State<KCNPicker> createState() => _KCNPickerState();
}

class _KCNPickerState extends State<KCNPicker> {
  TinhThanhModel? selectedTinhThanh;
  KCNModel? selectedKCN;

  List<KCNModel>? _kcns;

  @override
  void initState() {
    super.initState();
    // Initialize with initial values if provided
    if (widget.initialTinhThanhId != null || widget.initialKCNId != null) {
      // Load initial data here
    }
  }

  void _resetKCNs() {
    setState(() {
      _kcns = null;
      selectedKCN = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericPicker<TinhThanhModel>(
          label: 'Tỉnh/Thành phố',
          items: [], // Replace with actual TinhThanhModel list from BLoC/Repository
          initialValue: widget.initialTinhThanhId,
          hintText: 'Chọn tỉnh/thành phố',
          isLoading: false, // Set based on BLoC state
          onChanged: (TinhThanhModel? value) {
            setState(() {
              selectedTinhThanh = value;
            });
            _resetKCNs();
            if (value != null) {
              // Trigger BLoC event to load KCNs for this TinhThanh
              widget.onTinhThanhChanged?.call(value);
            }
          },
        ),
        const SizedBox(height: 14),
        GenericPicker<KCNModel>(
          label: 'Khu công nghiệp',
          items: _kcns ?? [],
          initialValue: widget.initialKCNId,
          hintText: 'Chọn khu công nghiệp',
          isLoading: false, // Set based on BLoC state
          onChanged: (KCNModel? value) {
            if (value != null) {
              setState(() {
                selectedKCN = value;
              });
              widget.onKCNChanged?.call(value);
            }
          },
        ),
      ],
    );
  }
}
