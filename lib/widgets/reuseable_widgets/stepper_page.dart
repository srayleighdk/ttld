import 'package:flutter/material.dart';

class StepperPage extends StatelessWidget {
  final List<String> steps;
  final int currentStep;
  final Widget stepContent;
  final Widget bottomNavigation;
  final Color? backgroundColor;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry stepperPadding;

  const StepperPage({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.stepContent,
    required this.bottomNavigation,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.all(16),
    this.stepperPadding = const EdgeInsets.symmetric(vertical: 16),
  });

  Widget _buildStepIndicator(int index) {
    final isCompleted = index < currentStep;
    final isCurrent = index == currentStep;

    return Expanded(
      child: Row(
        children: [
          // Step circle
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isCurrent ? Colors.blue : Colors.grey[300],
            ),
            child: Center(
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isCurrent ? Colors.white : Colors.grey[600],
                      ),
                    ),
            ),
          ),
          // Connecting line
          if (index < steps.length - 1)
            Expanded(
              child: Container(
                height: 2,
                color: isCompleted ? Colors.blue : Colors.grey[300],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom Progress Indicator
        Container(
          padding: stepperPadding,
          color: backgroundColor ?? Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(steps.length, (index) {
              return _buildStepIndicator(index);
            }),
          ),
        ),

        // Form Content
        Expanded(
          child: SingleChildScrollView(
            padding: contentPadding,
            child: stepContent,
          ),
        ),

        // Bottom Navigation
        bottomNavigation,
      ],
    );
  }
} 