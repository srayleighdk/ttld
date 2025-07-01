# Migration Guide: CustomTextField → ModernTextField

This guide helps you migrate from the existing `CustomTextField` to the new `ModernTextField` widget, which provides better design consistency, cleaner code, and improved maintainability.

## Why Migrate?

### Problems with CustomTextField
- ❌ **Hard-coded colors** instead of using project's theme system
- ❌ **Monolithic structure** with mixed responsibilities
- ❌ **Inconsistent validation** approaches
- ❌ **Poor maintainability** due to complex constructor
- ❌ **No design consistency** with project patterns

### Benefits of ModernTextField
- ✅ **Theme integration** with `NyColor` and `ColorStyles`
- ✅ **Clean architecture** with separated concerns
- ✅ **Consistent validation** using `FormValidator`
- ✅ **Easy maintenance** with well-structured code
- ✅ **Design consistency** following project patterns
- ✅ **Better accessibility** and user experience

## Migration Steps

### Step 1: Import the New Widget

```dart
// Replace this import
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

// With this import
import 'package:ttld/widgets/form/modern_text_field.dart';
```

### Step 2: Update Widget Usage

#### Basic Text Field

**Before:**
```dart
CustomTextField(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  controller: nameController,
  validator: 'not_empty',
  prefixIcon: Icon(Icons.person),
)
```

**After:**
```dart
ModernTextField(
  label: 'Full Name',
  hint: 'Enter your full name',
  controller: nameController,
  validators: [FormValidator.rule('required')],
  prefixIcon: Icon(Icons.person_outlined),
)
```

#### Email Field

**Before:**
```dart
CustomTextField.email(
  controller: emailController,
  validator: 'email',
)
```

**After:**
```dart
ModernTextField.email(
  controller: emailController,
  required: true,
)
```

#### Password Field

**Before:**
```dart
CustomTextField.password(
  controller: passwordController,
  validator: 'not_empty',
)
```

**After:**
```dart
ModernTextField.password(
  controller: passwordController,
  required: true,
  strengthLevel: 1, // or 2 for stronger validation
)
```

#### Number Field

**Before:**
```dart
CustomTextField.number(
  labelText: 'Age',
  hintText: 'Enter your age',
  controller: ageController,
  validator: 'not_empty',
  min: 18,
  max: 100,
)
```

**After:**
```dart
ModernTextField.number(
  label: 'Age',
  hint: 'Enter your age',
  controller: ageController,
  required: true,
  allowDecimals: false,
  min: 18,
  max: 100,
)
```

#### Text Area

**Before:**
```dart
CustomTextField.textArea(
  labelText: 'Description',
  hintText: 'Enter description',
  controller: descriptionController,
  minLines: 3,
  maxLines: 5,
  maxLength: 500,
)
```

**After:**
```dart
ModernTextField.textArea(
  label: 'Description',
  hint: 'Enter description',
  controller: descriptionController,
  minLines: 3,
  maxLines: 5,
  maxLength: 500,
)
```

### Step 3: Update Validation

#### String-based Validation

**Before:**
```dart
CustomTextField(
  validator: 'email',
  // or
  validator: 'not_empty',
  // or
  validator: 'phone',
)
```

**After:**
```dart
ModernTextField(
  validators: [
    FormValidator.email(),
    // or
    FormValidator.rule('required'),
    // or
    FormValidator.phoneNumber(),
  ],
)
```

#### Custom Validation

**Before:**
```dart
CustomTextField(
  validator: (String? value) {
    if (value == null || value.length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  },
)
```

**After:**
```dart
ModernTextField(
  customValidator: (String? value) {
    if (value == null || value.length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  },
)
```

### Step 4: Update Styling

#### Custom Decoration

**Before:**
```dart
CustomTextField(
  decoration: DecoratorTextField(
    decoration: (data, decoration) {
      return decoration.copyWith(
        contentPadding: EdgeInsets.all(16),
        fillColor: Colors.grey.shade50,
      );
    },
  ),
)
```

**After:**
```dart
ModernTextField(
  style: ModernTextFieldStyle(
    contentPadding: EdgeInsets.all(16),
    fillColor: NyColor(
      light: Colors.grey.shade50,
      dark: Colors.grey.shade900,
    ),
  ),
)
```

#### Predefined Styles

**Before:**
```dart
// No predefined styles available
CustomTextField(
  // Manual styling required
)
```

**After:**
```dart
// Compact style
ModernTextField(
  style: ModernTextFieldStyle.compact(),
)

// Prominent style
ModernTextField(
  style: ModernTextFieldStyle.prominent(),
)
```

## Property Mapping

| CustomTextField | ModernTextField | Notes |
|----------------|-----------------|-------|
| `labelText` | `label` | Direct replacement |
| `hintText` | `hint` | Direct replacement |
| `validator` (string) | `validators` (list) | Use `FormValidator` objects |
| `validator` (function) | `customValidator` | Direct replacement |
| `validateOnBlur` | `validateOnFocusLoss` | Same functionality |
| `autoValidate` | `validateOnChange` | Same functionality |
| `decoration` | `style` | Use `ModernTextFieldStyle` |
| `enabled` | `enabled` | Direct replacement |
| `readOnly` | `readOnly` | Direct replacement |
| `obscureText` | `obscureText` | Direct replacement |
| `keyboardType` | `keyboardType` | Direct replacement |
| `maxLines` | `maxLines` | Direct replacement |
| `minLines` | `minLines` | Direct replacement |
| `maxLength` | `maxLength` | Direct replacement |
| `inputFormatters` | `inputFormatters` | Direct replacement |
| `onChanged` | `onChanged` | Direct replacement |

## Advanced Migration Examples

### Complex Form Field

**Before:**
```dart
CustomTextField(
  labelText: 'Email Address',
  hintText: 'Enter your work email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  prefixIcon: Icon(Icons.email),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@company.com')) {
      return 'Must be a company email';
    }
    return null;
  },
  validateOnBlur: true,
  autoValidate: false,
  decoration: DecoratorTextField(
    decoration: (data, decoration) {
      return decoration.copyWith(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        fillColor: Colors.blue.shade50,
      );
    },
  ),
)
```

**After:**
```dart
ModernTextField.email(
  label: 'Email Address',
  hint: 'Enter your work email',
  controller: emailController,
  customValidator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@company.com')) {
      return 'Must be a company email';
    }
    return null;
  },
  validateOnFocusLoss: true,
  validateOnChange: false,
  style: ModernTextFieldStyle(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    fillColor: NyColor(
      light: Colors.blue.shade50,
      dark: Colors.blue.shade900,
    ),
  ),
)
```

### Address Detail Field

**Before:**
```dart
CustomTextField.addressDetail(
  controller: addressController,
  tinh: selectedTinh,
  huyen: selectedHuyen,
  xa: selectedXa,
  labelText: "Địa chỉ chi tiết",
  validator: 'not_empty',
)
```

**After:**
```dart
ModernTextField(
  label: "Địa chỉ chi tiết",
  hint: _buildAddressHint(selectedXa, selectedHuyen, selectedTinh),
  controller: addressController,
  validators: [FormValidator.rule('required')],
  keyboardType: TextInputType.streetAddress,
  prefixIcon: Icon(Icons.location_on_outlined),
)

// Helper function (you can create this in your widget)
String _buildAddressHint(String? xa, String? huyen, String? tinh) {
  String address = "";
  if (xa != null && xa.isNotEmpty) {
    address += "Xã $xa";
  }
  if (huyen != null && huyen.isNotEmpty) {
    if (address.isNotEmpty) address += ", ";
    address += "Huyện $huyen";
  }
  if (tinh != null && tinh.isNotEmpty) {
    if (address.isNotEmpty) address += ", ";
    address += "Tỉnh $tinh";
  }
  return address.isNotEmpty ? address : "Địa chỉ chi tiết";
}
```

## Testing Your Migration

### 1. Visual Testing
- Check that fields render correctly in both light and dark themes
- Verify that colors match the project's design system
- Test different screen sizes and orientations

### 2. Functional Testing
- Ensure validation works as expected
- Test all interactive elements (visibility toggle, clear button, etc.)
- Verify keyboard navigation and accessibility

### 3. Performance Testing
- Check that forms with many fields perform well
- Ensure no memory leaks from improper controller disposal

## Common Issues and Solutions

### Issue 1: Colors Don't Match Theme
**Problem:** Hard-coded colors from CustomTextField don't work with ModernTextField

**Solution:** Use `NyColor` for theme-aware colors:
```dart
// Instead of
fillColor: Colors.blue.shade50,

// Use
fillColor: NyColor(
  light: Colors.blue.shade50,
  dark: Colors.blue.shade900,
),
```

### Issue 2: Validation Not Working
**Problem:** String-based validation from CustomTextField doesn't work

**Solution:** Use `FormValidator` objects:
```dart
// Instead of
validator: 'email',

// Use
validators: [FormValidator.email()],
```

### Issue 3: Styling Differences
**Problem:** Fields look different after migration

**Solution:** Use appropriate `ModernTextFieldStyle`:
```dart
// For compact forms
style: ModernTextFieldStyle.compact(),

// For prominent fields
style: ModernTextFieldStyle.prominent(),

// For custom styling
style: ModernTextFieldStyle(
  contentPadding: EdgeInsets.all(16),
  // ... other properties
),
```

## Migration Checklist

- [ ] Replace import statements
- [ ] Update widget constructors
- [ ] Convert string validators to `FormValidator` objects
- [ ] Update custom validation functions
- [ ] Replace `DecoratorTextField` with `ModernTextFieldStyle`
- [ ] Test in both light and dark themes
- [ ] Verify accessibility features
- [ ] Test form validation
- [ ] Check performance with large forms
- [ ] Update any related documentation

## Gradual Migration Strategy

You don't need to migrate everything at once. Here's a suggested approach:

### Phase 1: New Features
- Use `ModernTextField` for all new forms and fields
- Get familiar with the new API and patterns

### Phase 2: Critical Forms
- Migrate login, registration, and other critical forms
- These benefit most from improved validation and accessibility

### Phase 3: Remaining Forms
- Gradually migrate other forms during regular maintenance
- Focus on forms that users interact with frequently

### Phase 4: Cleanup
- Remove unused `CustomTextField` imports
- Update documentation and examples
- Consider deprecating `CustomTextField`

## Getting Help

If you encounter issues during migration:

1. **Check the examples** in `modern_text_field_examples.dart`
2. **Review the documentation** in `lib/widgets/form/README.md`
3. **Run the tests** to ensure everything works correctly
4. **Ask for help** from the development team

## Conclusion

Migrating to `ModernTextField` will improve your app's:
- **Design consistency** with the project's theme system
- **Code maintainability** with cleaner, more structured code
- **User experience** with better accessibility and validation
- **Developer experience** with easier-to-use APIs

The migration process is straightforward, and the benefits are significant. Start with new features and gradually migrate existing code for the best results.