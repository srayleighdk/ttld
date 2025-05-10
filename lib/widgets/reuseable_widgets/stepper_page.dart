import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  final List<String> steps;
  final List<Widget> stepContents; // List of form widgets for each step
  final Color? backgroundColor;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry stepperPadding;
  final VoidCallback? onSubmit;
  final String? submitButtonText;

  const StepperPage({
    super.key,
    required this.steps,
    required this.stepContents,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.all(16),
    this.stepperPadding = const EdgeInsets.symmetric(vertical: 16),
    this.onSubmit,
    this.submitButtonText,
  }) : assert(steps.length == stepContents.length,
            'Steps and stepContents must have the same length');

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> with SingleTickerProviderStateMixin {
  late int _currentStep;
  final Map<int, GlobalKey<FormState>> _formKeys = {};
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    // Initialize form keys for each step
    for (int i = 0; i < widget.steps.length; i++) {
      _formKeys[i] = GlobalKey<FormState>();
    }

    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildStepIndicator(int index, ThemeData theme) {
    final isCompleted = index < _currentStep;
    final isCurrent = index == _currentStep;
    final primaryColor = theme.colorScheme.primary;
    final backgroundColor = theme.colorScheme.surface;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isCurrent ? primaryColor : backgroundColor,
              border: Border.all(
                color: isCompleted || isCurrent ? primaryColor : theme.colorScheme.outline,
                width: 2,
              ),
              boxShadow: [
                if (isCurrent)
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isCompleted
                    ? Icon(
                        Icons.check_rounded,
                        color: theme.colorScheme.onPrimary,
                        size: 20,
                      )
                    : Text(
                        '${index + 1}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isCurrent
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.steps[index],
              textAlign: TextAlign.center,
              maxLines: 2,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: isCurrent ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton.icon(
              onPressed: () {
                _animationController.reverse().then((_) {
                  setState(() => _currentStep--);
                  _animationController.forward();
                });
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Quay lại'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            )
          else
            const SizedBox.shrink(),
          FilledButton.icon(
            onPressed: () {
              if (_formKeys[_currentStep]!.currentState!.validate()) {
                if (_currentStep < widget.steps.length - 1) {
                  _animationController.reverse().then((_) {
                    setState(() => _currentStep++);
                    _animationController.forward();
                  });
                } else {
                  widget.onSubmit?.call();
                }
              }
            },
            icon: Icon(
              _currentStep < widget.steps.length - 1
                  ? Icons.arrow_forward_rounded
                  : Icons.check_rounded,
            ),
            label: Text(
              _currentStep < widget.steps.length - 1
                  ? 'Tiếp tục'
                  : (widget.submitButtonText ?? 'Hoàn thành'),
            ),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Column(
        children: [
          // Step Indicator
          Container(
            padding: widget.stepperPadding,
            color: widget.backgroundColor ?? theme.colorScheme.surface,
            child: Row(
              children: List.generate(
                widget.steps.length,
                (index) => _buildStepIndicator(index, theme),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: widget.contentPadding,
                  child: Form(
                    key: _formKeys[_currentStep],
                    child: widget.stepContents[_currentStep],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Navigation
          _buildBottomNavigation(theme),
        ],
      ),
    );
  }
}
