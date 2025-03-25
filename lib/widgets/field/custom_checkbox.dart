import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  final Color activeColor;
  final Color checkColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = '',
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          checkColor: checkColor,
        ),
        if (label.isNotEmpty) Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
