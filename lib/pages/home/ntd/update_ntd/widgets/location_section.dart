import 'package:flutter/material.dart';
import 'package:ttld/widgets/cascade_location_picker_grok.dart';

class LocationSection extends StatelessWidget {
  final String? initialTinh;
  final String? initialHuyen;
  final String? initialXa;
  final String? initialKCN;
  final TextEditingController addressDetailController;
  final Function(dynamic) onTinhChanged;
  final Function(dynamic) onHuyenChanged;
  final Function(dynamic) onXaChanged;
  final Function(dynamic) onKCNChanged;
  final ThemeData theme;

  const LocationSection({
    Key? key,
    required this.initialTinh,
    required this.initialHuyen,
    required this.initialXa,
    required this.initialKCN,
    required this.addressDetailController,
    required this.onTinhChanged,
    required this.onHuyenChanged,
    required this.onXaChanged,
    required this.onKCNChanged,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CascadeLocationPickerGrok(
        isNTD: true,
        initialTinh: initialTinh,
        initialHuyen: initialHuyen,
        initialXa: initialXa,
        initialKCN: initialKCN,
        addressDetailController: addressDetailController,
        onTinhChanged: onTinhChanged,
        onHuyenChanged: onHuyenChanged,
        onXaChanged: onXaChanged,
        onKCNChanged: onKCNChanged,
      ),
    );
  }
}