import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ttld/widgets/form/modern_text_field.dart';
import 'package:ttld/helppers/form_validation.dart';

void main() {
  group('ModernTextField', () {
    testWidgets('renders basic text field correctly', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField(
              label: 'Test Label',
              hint: 'Test Hint',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Hint'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('email factory constructor works correctly', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField.email(
              controller: controller,
              required: true,
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email address'), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('password factory constructor includes visibility toggle', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField.password(
              controller: controller,
              required: true,
            ),
          ),
        ),
      );

      expect(find.text('Password'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      
      // Test visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();
      
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('search field includes clear button when text is present', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField.search(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search_outlined), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsNothing);
      
      // Enter text
      await tester.enterText(find.byType(TextFormField), 'test search');
      await tester.pump();
      
      expect(find.byIcon(Icons.clear), findsOneWidget);
      
      // Test clear functionality
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();
      
      expect(controller.text, isEmpty);
    });

    testWidgets('number field only accepts numeric input', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField.number(
              controller: controller,
              allowDecimals: false,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'abc123def');
      await tester.pump();
      
      // Should only contain digits
      expect(controller.text, '123');
    });

    testWidgets('validation works correctly', (WidgetTester tester) async {
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: ModernTextField(
                label: 'Required Field',
                controller: controller,
                validators: [FormValidator.rule('required')],
              ),
            ),
          ),
        ),
      );

      // Validate empty field
      expect(formKey.currentState?.validate(), false);
      await tester.pump();
      
      expect(find.text('This field is required'), findsOneWidget);
      
      // Enter text and validate again
      await tester.enterText(find.byType(TextFormField), 'test');
      expect(formKey.currentState?.validate(), true);
    });

    testWidgets('custom validation works', (WidgetTester tester) async {
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: ModernTextField(
                label: 'Custom Validation',
                controller: controller,
                customValidator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Must be at least 5 characters';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Test with short text
      await tester.enterText(find.byType(TextFormField), 'abc');
      expect(formKey.currentState?.validate(), false);
      await tester.pump();
      
      expect(find.text('Must be at least 5 characters'), findsOneWidget);
      
      // Test with valid text
      await tester.enterText(find.byType(TextFormField), 'abcdef');
      expect(formKey.currentState?.validate(), true);
    });

    testWidgets('text area supports multiple lines', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField.textArea(
              controller: controller,
              minLines: 3,
              maxLines: 5,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.minLines, 3);
      expect(textField.maxLines, 5);
      expect(textField.keyboardType, TextInputType.multiline);
    });

    testWidgets('read-only field cannot be edited', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial text');
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField(
              controller: controller,
              readOnly: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'New text');
      await tester.pump();
      
      // Text should remain unchanged
      expect(controller.text, 'Initial text');
    });

    testWidgets('disabled field is not interactive', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField(
              controller: controller,
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, false);
    });

    testWidgets('onChanged callback is triggered', (WidgetTester tester) async {
      final controller = TextEditingController();
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModernTextField(
              controller: controller,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test');
      expect(changedValue, 'test');
    });
  });

  group('ModernTextFieldStyle', () {
    test('copyWith works correctly', () {
      const originalStyle = ModernTextFieldStyle(
        margin: EdgeInsets.all(8),
        filled: true,
      );
      
      final newStyle = originalStyle.copyWith(
        margin: const EdgeInsets.all(16),
      );
      
      expect(newStyle.margin, const EdgeInsets.all(16));
      expect(newStyle.filled, true); // Should preserve original value
    });

    test('factory constructors create correct styles', () {
      final compactStyle = ModernTextFieldStyle.compact();
      expect(compactStyle.margin, const EdgeInsets.symmetric(vertical: 4));
      
      final prominentStyle = ModernTextFieldStyle.prominent();
      expect(prominentStyle.margin, const EdgeInsets.symmetric(vertical: 12));
    });
  });
}