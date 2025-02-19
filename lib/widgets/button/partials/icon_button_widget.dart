import 'package:flutter/material.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/widgets/button/abstract/app_button.dart';

class IconButton extends AppButton {
  final Widget icon;
  final Color? color;

  const IconButton({
    super.key,
    required super.text,
    super.onPressed,
    required this.icon,
    this.color,
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          text,
          style: TextStyle(color: context.color.buttonContent),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? context.color.buttonBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
