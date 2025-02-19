import 'package:flutter/material.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/widgets/button/abstract/app_button.dart';

class TextOnlyButton extends AppButton {
  final Color? textColor;

  const TextOnlyButton({
    super.key,
    required super.text,
    super.onPressed,
    this.textColor,
    super.submitForm,
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: buildButtonChild(
        context,
        textColor: textColor ?? context.color.content,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
