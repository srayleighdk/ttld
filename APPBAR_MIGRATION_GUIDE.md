# AppBar Migration Guide

## Problem Statement

Multiple pages in the app have AppBar visibility issues where back buttons and action buttons are invisible due to poor color contrast. This happens when:

1. `backgroundColor: Colors.transparent` is used with light foreground colors
2. `foregroundColor: theme.colorScheme.onSurface` results in white/light colors on white backgrounds
3. Manual AppBar styling overrides theme defaults

## Affected Files

Based on analysis, the following files have potential issues:

### Critical Issues (transparent background + potential color conflicts):
- `lib/pages/home/ntv/tim_viec_page.dart` ✅ **FIXED**
- `lib/pages/signup/signup.dart`
- `lib/pages/home/lien_he_page.dart`
- `lib/pages/home/home_page.dart`
- `lib/pages/home/ntd/quan_ly_tuyen_dung/quan_ly_tuyen_dung.dart`
- `lib/pages/home/ntd/ntd_home.dart`
- `lib/pages/home/ntd/chap_noi_ntd_page.dart`
- `lib/pages/home/ntd/quan_ly_nhan_vien/quan_ly_nhan_vien.dart`
- `lib/pages/home/ntd/sgdvl_ntd_page.dart`
- `lib/pages/home/profile_page.dart`
- `lib/pages/home/ntv/chap_noi_page.dart`
- `lib/pages/home/ntv/ntv_home.dart`
- `lib/pages/home/ntv/update_ntv/update_ntv_page.dart`
- `lib/pages/hosochapnoi/hosochapnoi_page.dart`
- `lib/pages/login/login_page.dart`

### Moderate Issues (foregroundColor conflicts):
- `lib/pages/auth/change_password_page.dart`
- `lib/pages/home/ntd/create_tuyen_dung/create_tuyen_dung.dart`

## Solution

### 1. Created CustomAppBar Widget

A new `CustomAppBar` widget has been created at `lib/widgets/common/custom_app_bar.dart` that:

- **Ensures proper contrast** between background and foreground colors
- **Uses theme colors** by default for consistency
- **Provides fallback safety** to prevent invisible buttons
- **Maintains consistent styling** across the app

### 2. Updated Theme Configuration

Enhanced `lib/themes/light_theme.dart` to include:
- `foregroundColor` in AppBarTheme
- `actionsIconTheme` for action button colors
- `centerTitle: true` as default

### 3. Migration Pattern

**Before (Problematic):**
```dart
AppBar(
  backgroundColor: Colors.transparent,
  foregroundColor: theme.colorScheme.onSurface,
  title: Text(
    'Page Title',
    style: theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.onSurface,
    ),
  ),
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    ),
  ],
)
```

**After (Fixed):**
```dart
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

## Implementation Steps

### Step 1: Import CustomAppBar
```dart
import 'package:ttld/widgets/common/custom_app_bar.dart';
```

### Step 2: Replace AppBar with CustomAppBar
- Change `AppBar(` to `CustomAppBar(`
- Replace `title: Text(...)` with `title: 'String'`
- Remove manual color styling
- Keep actions, leading, and other properties as-is

### Step 3: For Transparent AppBars (Special Cases)
If you specifically need a transparent background:
```dart
TransparentAppBar(
  title: 'Page Title',
  actions: [...],
)
```

## Benefits

1. **Consistent UI** - All AppBars follow the same design pattern
2. **No invisible buttons** - Automatic contrast detection prevents visibility issues
3. **Theme integration** - Uses app theme colors properly
4. **Maintainable code** - Centralized AppBar logic
5. **Future-proof** - Easy to update styling across all pages

## Testing Checklist

After migration, verify:
- [ ] Back button is visible and functional
- [ ] Action buttons are visible and functional
- [ ] Title text is readable
- [ ] AppBar matches app theme
- [ ] No visual regressions on different screen sizes
- [ ] Works in both light and dark themes (if applicable)

## Priority Order for Migration

1. **High Priority** - Pages with `backgroundColor: Colors.transparent`
2. **Medium Priority** - Pages with manual foregroundColor settings
3. **Low Priority** - Pages already using theme colors correctly

## Example Migration

See `lib/pages/home/ntv/tim_viec_page.dart` for a complete example of the migration.

## Support

For questions or issues with migration:
1. Check the CustomAppBar documentation in `lib/widgets/common/README.md`
2. Review the example implementation in `tim_viec_page.dart`
3. Test with different theme configurations to ensure compatibility