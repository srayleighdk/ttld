import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  final List<String> steps;
  final List<Widget> stepContents; // List of form widgets for each step
  final Color? backgroundColor;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry stepperPadding;
  final VoidCallback? onComplete; // Callback when all steps are completed

  const StepperPage({
    super.key,
    required this.steps,
    required this.stepContents,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.all(16),
    this.stepperPadding = const EdgeInsets.symmetric(vertical: 16),
    this.onComplete,
  }) : assert(steps.length == stepContents.length,
            'Steps and stepContents must have the same length');

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  late int _currentStep;
  final Map<int, GlobalKey<FormState>> _formKeys = {};

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    // Initialize form keys for each step
    for (int i = 0; i < widget.steps.length; i++) {
      _formKeys[i] = GlobalKey<FormState>();
    }
  }

  Widget _buildStepIndicator(int index) {
    final isCompleted = index < _currentStep;
    final isCurrent = index == _currentStep;

    return Expanded(
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isCurrent ? Colors.blue : Colors.grey[300],
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isCurrent ? Colors.white : Colors.grey[600],
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
            ),
          ),
          if (index < widget.steps.length - 1)
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

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: _currentStep > 0
                ? () => setState(() => _currentStep--)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
            ),
            child: const Text('Previous'),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate current form
              if (_formKeys[_currentStep]!.currentState!.validate()) {
                if (_currentStep < widget.steps.length - 1) {
                  setState(() => _currentStep++);
                } else {
                  widget.onComplete?.call();
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(
              _currentStep < widget.steps.length - 1 ? 'Next' : 'Finish',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Step Indicator
          Container(
            padding: widget.stepperPadding,
            color: widget.backgroundColor ?? Colors.grey[100],
            child: Row(
              children: List.generate(
                widget.steps.length,
                (index) => _buildStepIndicator(index),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: widget.contentPadding,
              child: Form(
                key: _formKeys[_currentStep],
                child: widget.stepContents[_currentStep],
              ),
            ),
          ),

          // Bottom Navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }
}
