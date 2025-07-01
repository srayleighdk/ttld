# Reusable Widgets

This directory contains reusable widgets that can be used across the application.

## ModernPicker

`ModernPicker` is a theme-aware dropdown picker component designed to be consistent with `ModernTextField`. It provides a unified form experience with consistent styling, validation, and behavior.

### Usage

```dart
ModernPicker<GenericPickerItem>(
  label: 'Country',
  hint: 'Select a country',
  helperText: 'Choose your country of residence',
  initialValue: selectedCountryId,
  items: countries,
  onChanged: (country) {
    // Handle selection change
  },
  validator: (value) {
    if (value == null) {
      return 'Please select a country';
    }
    return null;
  },
  isLoading: isLoadingCountries,
  prefixIcon: Icon(Icons.flag),
)
```

### Styling

`ModernPicker` uses `ModernPickerStyle` for styling, which is designed to be consistent with `ModernTextFieldStyle`:

```dart
ModernPicker<GenericPickerItem>(
  // ...
  style: ModernPickerStyle(
    margin: EdgeInsets.symmetric(vertical: 8),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    filled: true,
    // Other styling options
  ),
)
```

Predefined styles:
- `ModernPickerStyle.defaultStyle(context)`
- `ModernPickerStyle.compact()`
- `ModernPickerStyle.prominent()`

## GenericPicker (Legacy)

`GenericPicker` is maintained for backward compatibility. New code should use `ModernPicker` instead.

## Migration Guide

### From GenericPicker to ModernPicker

```dart
// Old code
GenericPicker<NganhNgheKT>(
  label: 'Industry',
  hintText: 'Select an industry',
  initialValue: selectedIndustryId,
  items: industries,
  onChanged: (industry) {
    // Handle selection
  },
  isLoading: isLoadingIndustries,
)

// New code
ModernPicker<NganhNgheKT>(
  label: 'Industry',
  hint: 'Select an industry',
  initialValue: selectedIndustryId,
  items: industries,
  onChanged: (industry) {
    // Handle selection
  },
  isLoading: isLoadingIndustries,
)
```

### From CustomPickerGrok to ModernPicker

```dart
// Old code
CustomPickerGrok<QuocGia>(
  label: const Text("Country"),
  items: countries,
  selectedItem: selectedCountry,
  onChanged: (value) {
    // Handle selection
  },
  displayItemBuilder: (QuocGia? item) => item?.displayName ?? '',
  hint: 'Select a country',
  isLoading: isLoadingCountries,
)

// New code
ModernPicker<QuocGia>(
  label: "Country",
  items: countries,
  initialValue: selectedCountry?.id,
  onChanged: (value) {
    // Handle selection
  },
  hint: 'Select a country',
  isLoading: isLoadingCountries,
)
```