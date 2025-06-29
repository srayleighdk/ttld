# ChapNoi Date Format Fix

## Issue
When attempting to create a ChapNoi record (job application), the following error occurred:
```
Error in ChapNoiRepository createChapNoi: Exception: Error: Validation failed for parameter '5'. Invalid date.
```

## Root Cause Analysis
After examining the API response data, I identified several issues:

1. **Date Format**: The API expects dates in a specific format: `"2025-06-26T17:00:00.000Z"` (ISO 8601 with milliseconds and Z timezone)
2. **Connection Type**: The API expects a specific connection type code (e.g., `"GGT"` for "Giấy giới thiệu") rather than a numeric ID
3. **Error Handling**: The error handling for the ChapNoi creation was not properly set up to catch API validation errors

## Fixes Implemented

### 1. Date Format Correction
Created a helper method to properly format dates for the API:
```dart
String _formatDateForAPI(DateTime dateTime) {
  // Format: "2025-06-26T17:00:00.000Z"
  final utcDate = dateTime.toUtc();
  final isoString = utcDate.toIso8601String();
  
  // If the ISO string already has milliseconds, use it
  if (isoString.contains('.')) {
    return isoString;
  } else {
    // Add milliseconds if not present
    return "${isoString.split('Z')[0]}.000Z";
  }
}
```

### 2. Connection Type Correction
Changed the connection type from `'1'` to `'GGT'` (Giấy giới thiệu) based on the API response data:
```dart
final chapNoi = ChapNoiModel(
  idKieuChapNoi: 'GGT', // Use proper connection type code
  // other fields...
);
```

### 3. Improved Error Handling
Added better error handling with proper subscription management:
```dart
// Add a listener before dispatching the event
final subscription = _chapNoiBloc.stream.listen((state) {
  if (state is ChapNoiListLoaded) {
    // Success handling
    subscription.cancel(); // Cancel subscription
  } else if (state is ChapNoiError) {
    // Error handling
    subscription.cancel(); // Cancel subscription
  }
});

// Dispatch the event after setting up the listener
_chapNoiBloc.add(ChapNoiCreate(chapNoi));
```

## Files Modified
1. `lib/pages/home/ntd/ntd_tuyendung_info_page.dart`
2. `lib/pages/home/ntv/tim_viec_page.dart`

## Testing
The fix has been implemented and should resolve the date validation error. The changes ensure:
1. Dates are properly formatted to match API expectations
2. The correct connection type code is used
3. Error handling is improved to provide better feedback

## Future Recommendations
1. Consider fetching available connection types dynamically from the API
2. Add validation to ensure dates are within acceptable ranges
3. Implement a centralized date formatting utility for consistent API date handling