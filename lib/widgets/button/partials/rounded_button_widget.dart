import 'package:flutter/material.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/widgets/button/abstract/app_button.dart';

class RoundedButton extends AppButton {
  final Color? color;
  final BorderRadius? borderRadius;

  const RoundedButton({
    super.key,
    required super.text,
    super.onPressed,
    this.color,
    this.borderRadius,
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? context.color.buttonBackground,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
        ),
      ),
      child: buildButtonChild(
        context,
        textColor: context.color.buttonContent,
        backgroundColor: Colors.transparent,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
