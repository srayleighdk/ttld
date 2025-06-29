# ChapNoi Bloc Lifecycle Management Fix

## Issue
When navigating to the ChapNoi page after applying for a job, the following error occurred:
```
Another exception was thrown: Bad state: Cannot add new events after calling close
```

This error happens when trying to add events to a bloc that has already been closed, typically when navigating between pages that use the same bloc.

## Root Cause Analysis
1. The ChapNoiBloc was being closed in the `dispose()` method of pages that used it
2. When navigating to the ChapNoi page later, the app tried to use the same (now closed) bloc
3. StreamSubscriptions were not being properly managed, leading to potential memory leaks

## Fixes Implemented

### 1. Proper Bloc Lifecycle Management
- Removed `_chapNoiBloc.close()` calls from the `dispose()` methods
- Added comments explaining that the bloc is managed by the locator (dependency injection)
```dart
// Don't close _chapNoiBloc here as it's managed by the locator
// and might be needed by other pages
```

### 2. Improved StreamSubscription Management
- Changed `late final StreamSubscription` to `StreamSubscription?` for nullable safety
- Added a class-level list to track all active subscriptions
```dart
// Track active subscriptions for cleanup
final List<StreamSubscription> _activeSubscriptions = [];
```
- Properly canceled all subscriptions in the `dispose()` method
```dart
// Cancel any active subscriptions
for (var subscription in _activeSubscriptions) {
  subscription.cancel();
}
_activeSubscriptions.clear();
```
- Added null-safe subscription cancellation
```dart
streamSubscription?.cancel();
streamSubscription = null;
```

### 3. Added Widget Lifecycle Checks
- Added `mounted` checks before calling `setState()` or showing toasts
```dart
if (mounted) {
  setState(() {
    isApplying = false;
  });
  ToastUtils.showSuccessToast(
    context,
    'Ứng tuyển thành công! Hồ sơ của bạn đã được gửi đến nhà tuyển dụng.',
  );
}
```
- Added delayed navigation to ensure operations complete
```dart
Future.delayed(const Duration(milliseconds: 300), () {
  if (mounted) {
    Navigator.of(context).pop();
  }
});
```

## Files Modified
1. `lib/pages/home/ntd/ntd_tuyendung_info_page.dart`
2. `lib/pages/home/ntv/tim_viec_page.dart`

## Benefits of the Fix
1. **Prevents Bloc Closure Issues**: The ChapNoiBloc remains available throughout the app's lifecycle
2. **Prevents Memory Leaks**: All StreamSubscriptions are properly tracked and canceled
3. **Prevents Widget Errors**: Added checks to ensure widgets are still mounted before updating state
4. **Improves Navigation**: Added delayed navigation to ensure operations complete before navigating

## Best Practices Implemented
1. **Singleton Bloc Management**: Blocs registered with GetIt should not be closed by individual widgets
2. **StreamSubscription Tracking**: All subscriptions are tracked and properly disposed
3. **Widget Lifecycle Awareness**: Added checks to prevent calling setState on unmounted widgets
4. **Null Safety**: Used nullable types and null-safe operators for better error prevention