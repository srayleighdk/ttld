# ModernTextField Widget

A modern, theme-aware text field widget that follows the project's design system and provides a clean, maintainable alternative to the existing `CustomTextField`.

## Features

- ✅ **Theme Integration**: Uses project's `NyColor` and `ColorStyles` system
- ✅ **Built-in Validation**: Integrates with `FormValidator` system
- ✅ **Multiple Field Types**: Email, password, phone, number, search, text area
- ✅ **Clean Architecture**: Separated concerns and responsibilities
- ✅ **Accessibility**: Proper labels, hints, and error messages
- ✅ **Responsive Design**: Adapts to different screen sizes
- ✅ **Easy Maintenance**: Well-structured, documented code

## Basic Usage

```dart
import 'package:ttld/widgets/form/modern_text_field.dart';

// Basic text field
ModernTextField(
  label: 'Full Name',
  hint: 'Enter your full name',
  controller: nameController,
  validators: [FormValidator.rule('required')],
)
```

## Factory Constructors

### Email Field
```dart
ModernTextField.email(
  controller: emailController,
  required: true,
)
```

### Password Field
```dart
ModernTextField.password(
  controller: passwordController,
  required: true,
  strengthLevel: 2, // 1 or 2
)
```

### Phone Field
```dart
ModernTextField.phone(
  controller: phoneController,
  required: true,
)
```

### Number Field
```dart
ModernTextField.number(
  label: 'Age',
  controller: ageController,
  allowDecimals: false,
  min: 18,
  max: 100,
)
```

### Text Area
```dart
ModernTextField.textArea(
  label: 'Description',
  hint: 'Enter description...',
  controller: descriptionController,
  minLines: 3,
  maxLines: 6,
  maxLength: 500,
)
```

### Search Field
```dart
ModernTextField.search(
  hint: 'Search...',
  controller: searchController,
  onChanged: (value) => performSearch(value),
  onClear: () => clearSearch(),
)
```

## Styling

### Default Style
```dart
ModernTextField(
  label: 'Default',
  hint: 'Uses default styling',
  style: ModernTextFieldStyle.defaultStyle(context),
)
```

### Compact Style
```dart
ModernTextField(
  label: 'Compact',
  hint: 'Smaller padding and margins',
  style: ModernTextFieldStyle.compact(),
)
```

### Prominent Style
```dart
ModernTextField(
  label: 'Prominent',
  hint: 'Larger padding for important fields',
  style: ModernTextFieldStyle.prominent(),
)
```

### Custom Style
```dart
ModernTextField(
  label: 'Custom',
  hint: 'Custom styling',
  style: ModernTextFieldStyle(
    margin: EdgeInsets.symmetric(vertical: 12),
    contentPadding: EdgeInsets.all(20),
    filled: true,
    fillColor: NyColor(
      light: Colors.grey.shade50,
      dark: Colors.grey.shade900,
    ),
  ),
)
```

## Validation

### Built-in Validators
```dart
ModernTextField(
  label: 'Email',
  validators: [
    FormValidator.rule('required'),
    FormValidator.email(),
  ],
)
```

### Custom Validation
```dart
ModernTextField(
  label: 'Username',
  customValidator: (value) {
    if (value == null || value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  },
  validateOnChange: true,
)
```

### Validation Timing
```dart
ModernTextField(
  label: 'Field',
  validateOnChange: true,     // Validate as user types
  validateOnFocusLoss: true,  // Validate when field loses focus
)
```

## Advanced Features

### Input Formatting
```dart
ModernTextField(
  label: 'Phone',
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ],
)
```

### Prefix/Suffix Elements
```dart
ModernTextField(
  label: 'Price',
  prefixText: '\$ ',
  suffixIcon: Icon(Icons.attach_money),
  keyboardType: TextInputType.number,
)
```

### Read-only and Disabled States
```dart
// Read-only
ModernTextField(
  label: 'ID',
  readOnly: true,
  controller: TextEditingController(text: 'AUTO-123'),
)

// Disabled
ModernTextField(
  label: 'Disabled',
  enabled: false,
)
```

## Form Integration

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ModernTextField(
            label: 'Name',
            controller: _nameController,
            validators: [FormValidator.rule('required')],
          ),
          
          ModernTextField.email(
            controller: _emailController,
            required: true,
          ),
          
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, submit data
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
    }
  }
}
```

## Migration from CustomTextField

### Before (CustomTextField)
```dart
CustomTextField(
  labelText: 'Email',
  hintText: 'Enter your email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  prefixIcon: Icon(Icons.email),
  validator: 'email',
)
```

### After (ModernTextField)
```dart
ModernTextField.email(
  controller: emailController,
  required: true,
)
```

## Theme Integration

The widget automatically uses your app's theme colors:

- **Primary Color**: For focused borders and labels
- **Error Color**: For validation errors
- **Surface Colors**: For backgrounds and content
- **Content Colors**: For text and borders

Colors are resolved using the project's `NyColor` system, ensuring proper light/dark theme support.

## Accessibility

- Proper semantic labels
- Screen reader support
- Keyboard navigation
- High contrast support
- Tooltip support for interactive elements

## Performance

- Efficient state management
- Minimal rebuilds
- Proper disposal of resources
- Optimized for large forms

## Examples

See `modern_text_field_examples.dart` for comprehensive examples including:

- Basic form fields
- Login form
- Multi-step registration form
- Different styling options
- Validation scenarios

## Best Practices

1. **Use factory constructors** for common field types
2. **Provide meaningful labels and hints** for accessibility
3. **Use appropriate validation** for data integrity
4. **Choose the right style** for your use case
5. **Dispose controllers** properly to prevent memory leaks
6. **Use helper text** to guide users
7. **Test with different themes** to ensure consistency

## Comparison with CustomTextField

| Feature | CustomTextField | ModernTextField |
|---------|----------------|-----------------|
| Theme Integration | ❌ Hard-coded colors | ✅ Uses project theme system |
| Code Structure | ❌ Monolithic | ✅ Clean, separated concerns |
| Validation | ❌ Mixed approaches | ✅ Consistent validation system |
| Factory Constructors | ⚠️ Limited | ✅ Comprehensive |
| Styling Options | ⚠️ Basic | ✅ Flexible styling system |
| Accessibility | ⚠️ Basic | ✅ Full accessibility support |
| Maintainability | ❌ Difficult | ✅ Easy to maintain |
| Documentation | ❌ Limited | ✅ Comprehensive |

## Future Enhancements

- [ ] Auto-complete support
- [ ] Rich text formatting
- [ ] File upload integration
- [ ] Internationalization support
- [ ] Advanced validation rules
- [ ] Animation improvements