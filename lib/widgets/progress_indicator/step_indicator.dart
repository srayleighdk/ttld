import 'package:flutter/material.dart';

// Step Indicator Widget
Widget buildStepIndicator({
  required int index,
  required int currentStep,
  required List<String> steps,
  double circleSize = 32.0,
  Color activeColor = Colors.green,
  Color currentColor = Colors.blue,
  Color inactiveColor = const Color(0xFFE0E0E0),
  Color activeTextColor = Colors.white,
  Color inactiveTextColor = const Color(0xFF757575),
  Color currentTextColor = Colors.blue,
  double fontSize = 12.0,
  double spacing = 4.0,
  double lineHeight = 2.0,
}) {
  bool isActive = index <= currentStep;
  bool isCurrent = index == currentStep;

  return Expanded(
    child: Column(
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent
                ? currentColor
                : isActive
                    ? activeColor
                    : inactiveColor,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isActive ? activeTextColor : inactiveTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: spacing),
        Text(
          steps[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isCurrent
                ? currentTextColor
                : isActive
                    ? Colors.black
                    : inactiveTextColor,
            fontSize: fontSize,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (index < steps.length - 1)
          Container(
            height: lineHeight,
            color: isActive ? activeColor : inactiveColor,
          ),
      ],
    ),
  );
}

// Step Content Widget
Widget buildStepContent({
  required int currentStep,
  required List<Widget> stepWidgets,
}) {
  if (currentStep >= 0 && currentStep < stepWidgets.length) {
    return stepWidgets[currentStep];
  }
  return Container();
}

// Bottom Navigation Widget
Widget buildBottomNavigation({
  required int currentStep,
  required List<String> steps,
  required List<GlobalKey<FormState>?> formKeys,
  required VoidCallback onSubmit,
  required Function(int) onStepChanged,
  String backText = 'Quay lại',
  String nextText = 'Tiếp tục',
  String completeText = 'Hoàn thành',
  Color nextButtonColor = Colors.blue,
  Color backButtonColor = const Color(0xFFE0E0E0),
  double padding = 16.0,
}) {
  return Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 0)
          ElevatedButton(
            onPressed: () => onStepChanged(currentStep - 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: backButtonColor,
              foregroundColor: Colors.black,
            ),
            child: Row(
              children: [
                Icon(Icons.arrow_back, size: 16),
                SizedBox(width: 8),
                Text(backText),
              ],
            ),
          )
        else
          SizedBox(width: 100),
        ElevatedButton(
          onPressed: () {
            final currentFormKey = formKeys[currentStep];
            if (currentFormKey?.currentState?.validate() ?? false) {
              currentFormKey?.currentState?.save();
              if (currentStep < steps.length - 1) {
                onStepChanged(currentStep + 1);
              } else {
                onSubmit();
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: nextButtonColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Row(
            children: [
              Text(currentStep == steps.length - 1 ? completeText : nextText),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}
