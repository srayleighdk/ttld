import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  final Color activeColor;
  final Color checkColor;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label = '',
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
