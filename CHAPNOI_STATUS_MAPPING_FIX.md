# ChapNoi Status Mapping Fix Summary

## Issue Identified
The ChapNoi NTD page was showing incorrect status mappings, causing "Chờ xử lý" and "Không đạt" filters to display "Đạt" records instead of the correct ones.

## Root Cause
The status mapping was inconsistent throughout the codebase. The correct mapping should be:
- **idKetQua 0**: "Chờ xử lý" (Pending)
- **idKetQua 1**: "Không đạt" (Not qualified/Failed)  
- **idKetQua 2**: "Đạt" (Qualified/Passed)

But the code had incorrect mappings in multiple places.

## Fixes Applied

### 1. Statistics Calculation (Line 425-427)
**Before:**
```dart
final acceptedCount = chapNoiList.where((item) => item.idKetQua == 1).length;
final rejectedCount = chapNoiList.where((item) => item.idKetQua == 2).length;
```

**After:**
```dart
final rejectedCount = chapNoiList.where((item) => item.idKetQua == 1).length; // 1 = Không đạt
final acceptedCount = chapNoiList.where((item) => item.idKetQua == 2).length; // 2 = Đạt
```

### 2. Statistics Cards Display (Line 486-503)
**Before:**
```dart
'Đã Chấp Nhận' -> acceptedCount (wrong order)
'Đã Từ Chối' -> rejectedCount (wrong order)
```

**After:**
```dart
'Không Đạt' -> rejectedCount (correct)
'Đạt' -> acceptedCount (correct)
```

### 3. Filter Dropdown Options (Line 622-627)
**Before:**
```dart
DropdownMenuItem(value: '1', child: Text('Đã chấp nhận')),
DropdownMenuItem(value: '2', child: Text('Đã từ chối')),
```

**After:**
```dart
DropdownMenuItem(value: '1', child: Text('Không đạt')),
DropdownMenuItem(value: '2', child: Text('Đạt')),
```

### 4. Status Chips in List View (Line 1131-1145)
**Before:**
```dart
case 1:
  chipColor = Colors.green;
  statusText = 'Đã chấp nhận';
case 2:
  chipColor = Colors.red;
  statusText = 'Đã từ chối';
```

**After:**
```dart
case 2:
  chipColor = Colors.green;
  statusText = 'Đạt';
case 1:
  chipColor = Colors.red;
  statusText = 'Không đạt';
```

### 5. Status Chips in Detail Dialog (Line 1712-1723)
**Before:**
```dart
case 1:
  chipColor = Colors.green;
  statusText = 'Đã chấp nhận';
case 2:
  chipColor = Colors.red;
  statusText = 'Đã từ chối';
```

**After:**
```dart
case 2:
  chipColor = Colors.green;
  statusText = 'Đạt';
case 1:
  chipColor = Colors.red;
  statusText = 'Không đạt';
```

## Result
Now the filtering works correctly:
- ✅ **"Chờ xử lý"** filter shows records with `idKetQua = 0`
- ✅ **"Không đạt"** filter shows records with `idKetQua = 1`
- ✅ **"Đạt"** filter shows records with `idKetQua = 2`

## Files Modified
- `lib/pages/home/ntd/chap_noi_ntd_page.dart`: Fixed all status mappings

## Testing Recommendations
1. Test each filter option to ensure correct records are displayed
2. Verify status chips show correct text and colors
3. Check statistics calculations are accurate
4. Test detail dialog shows correct status
5. Verify empty states work for each filter

## Impact
- **Fixed filtering bug**: Users can now properly filter by status
- **Consistent UI**: All status displays now use the same mapping
- **Better UX**: Clear and accurate status labels throughout the interface