# Common Widgets

## CustomAppBar

A standardized AppBar widget that ensures consistent styling and prevents visibility issues across the app.

### Problem Solved

Previously, many pages used:
```dart
AppBar(
  backgroundColor: Colors.transparent,
  foregroundColor: theme.colorScheme.onSurface,
  // ... other properties
)
```

This caused invisible back/action buttons when the background and foreground colors were too similar.

### Usage

#### Standard AppBar (Recommended)
```dart
import 'package:ttld/widgets/common/custom_app_bar.dart';

CustomAppBar(
  title: 'Page Title',
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    ),
  ],
)
```

#### Transparent AppBar (Use with caution)
```dart
TransparentAppBar(
  title: 'Page Title',
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    ),
  ],
)
```

### Features

1. **Automatic contrast detection** - Prevents invisible buttons
2. **Theme integration** - Uses app theme colors by default
3. **Consistent styling** - Same look across all pages
4. **Fallback safety** - Always ensures readable text/icons
5. **Simple implementation** - No complex theme provider dependencies

### Migration Guide

Replace existing AppBar usage:

**Before:**
```dart
AppBar(
  backgroundColor: Colors.transparent,
  foregroundColor: theme.colorScheme.onSurface,
  title: Text('Title'),
  actions: [...],
)
```

**After:**
```dart
CustomAppBar(
  title: 'Title',
  actions: [...],
)
```

### Parameters

- `title`: String title (automatically styled)
- `actions`: List of action widgets
- `leading`: Custom leading widget
- `centerTitle`: Whether to center the title (default: true)
- `elevation`: AppBar elevation (default: 1.0)
- `backgroundColor`: Override background color
- `foregroundColor`: Override foreground color
- `useThemeColors`: Use theme-defined colors (default: true)