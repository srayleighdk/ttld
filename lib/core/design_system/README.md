# TTLD Design System

A modern, comprehensive design system for the TTLD (Thị Trường Lao Động) Flutter application.

## Quick Start

### Installation

Import the design system in your Dart files:

```dart
import 'package:ttld/core/design_system/design_system.dart';
```

### Basic Usage

#### Colors
```dart
Container(
  color: AppColors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.textOnPrimary),
  ),
)
```

#### Typography
```dart
Text(
  'Welcome',
  style: AppTypography.headlineLarge,
)
```

#### Spacing
```dart
Padding(
  padding: EdgeInsets.all(AppSpacing.lg),
  child: YourWidget(),
)
```

#### Buttons
```dart
AppButton.primary(
  text: 'Submit',
  onPressed: () {},
  isFullWidth: true,
)
```

#### Text Fields
```dart
AppTextField.email(
  controller: emailController,
  label: 'Email Address',
)
```

#### Cards
```dart
AppCard.elevated(
  child: Text('Card Content'),
)
```

## Features

### Design Tokens
- **Colors**: Comprehensive color palette with semantic colors
- **Typography**: Consistent text styles for all use cases
- **Spacing**: 8-point grid system for consistent spacing
- **Border Radius**: Predefined radius values for components
- **Shadows**: Elevation system for depth and hierarchy

### Components
- **AppButton**: Modern button with multiple variants (primary, secondary, outline, text)
- **AppTextField**: Text input with built-in validation and variants (email, password, search)
- **AppCard**: Container component with elevation and outline variants
- **AppInfoCard**: Card with icon and content
- **AppStatCard**: Metric display card with trends
- **AppLoading**: Loading indicators and shimmer effects

### Pages
- **ModernLoginPage**: Redesigned login page with animations
- **ModernSplashPage**: Animated splash screen

## Component Examples

### Login Form
```dart
Form(
  child: Column(
    children: [
      AppTextField.email(
        controller: emailController,
        label: 'Email',
      ),
      SizedBox(height: AppSpacing.lg),
      AppTextField.password(
        controller: passwordController,
        label: 'Password',
      ),
      SizedBox(height: AppSpacing.xxl),
      AppButton.primary(
        text: 'Login',
        onPressed: handleLogin,
        isFullWidth: true,
        isLoading: isLoading,
      ),
    ],
  ),
)
```

### Info Cards
```dart
Column(
  children: [
    AppInfoCard(
      icon: Icons.person,
      title: 'Profile',
      subtitle: 'Manage your profile',
      onTap: () => navigateToProfile(),
    ),
    SizedBox(height: AppSpacing.md),
    AppInfoCard(
      icon: Icons.settings,
      title: 'Settings',
      subtitle: 'App preferences',
      onTap: () => navigateToSettings(),
    ),
  ],
)
```

### Statistics Grid
```dart
GridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: AppSpacing.md,
  crossAxisSpacing: AppSpacing.md,
  children: [
    AppStatCard(
      label: 'Total Jobs',
      value: '156',
      icon: Icons.work,
      color: AppColors.primary,
      trend: '+12%',
      isPositiveTrend: true,
    ),
    AppStatCard(
      label: 'Applicants',
      value: '1,234',
      icon: Icons.people,
      color: AppColors.secondary,
      trend: '+8%',
      isPositiveTrend: true,
    ),
  ],
)
```

## Design Principles

1. **Consistency**: Use design tokens for all styling decisions
2. **Accessibility**: Ensure WCAG AA compliance
3. **Simplicity**: Keep interfaces clean and focused
4. **Responsiveness**: Design for all screen sizes
5. **Performance**: Optimize for smooth animations and fast rendering

## File Structure

```
lib/core/design_system/
├── design_system.dart          # Main export file
├── README.md                   # This file
├── app_colors.dart            # Color palette
├── app_typography.dart        # Text styles
├── app_spacing.dart           # Spacing system
├── app_radius.dart            # Border radius
├── app_shadows.dart           # Shadow system
└── widgets/
    ├── app_button.dart        # Button component
    ├── app_text_field.dart    # Text input component
    ├── app_card.dart          # Card components
    └── app_loading.dart       # Loading components
```

## Migration Guide

### Step 1: Import Design System
```dart
import 'package:ttld/core/design_system/design_system.dart';
```

### Step 2: Replace Custom Colors
```dart
// Before
color: Color(0xFF0045a0)

// After
color: AppColors.primary
```

### Step 3: Replace Custom Text Styles
```dart
// Before
TextStyle(fontSize: 24, fontWeight: FontWeight.bold)

// After
AppTypography.headlineSmall
```

### Step 4: Replace Custom Spacing
```dart
// Before
padding: EdgeInsets.all(16)

// After
padding: EdgeInsets.all(AppSpacing.lg)
```

### Step 5: Use Design System Components
```dart
// Before
ElevatedButton(
  onPressed: () {},
  child: Text('Submit'),
)

// After
AppButton.primary(
  text: 'Submit',
  onPressed: () {},
)
```

## Best Practices

### DO ✅
- Use design tokens for all styling
- Compose complex UIs from simple components
- Keep components focused and reusable
- Test components for accessibility
- Document custom components

### DON'T ❌
- Don't use hardcoded colors or sizes
- Don't create custom components for existing patterns
- Don't mix design system with custom styling
- Don't ignore accessibility guidelines
- Don't skip documentation

## Contributing

When adding new components or tokens:

1. Follow existing naming conventions
2. Add documentation and examples
3. Ensure accessibility compliance
4. Test on multiple screen sizes
5. Update this README

## Resources

- [Full Documentation](../../DESIGN_SYSTEM.md)
- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design](https://material.io/design)
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

## Support

For questions or issues:
- Check the [full documentation](../../DESIGN_SYSTEM.md)
- Contact the development team
- Create an issue in the repository
