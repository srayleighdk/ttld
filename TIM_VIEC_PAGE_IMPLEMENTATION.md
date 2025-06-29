# TimViecPage Implementation with idUV Parameter

## Overview

Successfully implemented the `idUV` parameter for fetching tuyen dung (job listings) in `tim_viec_page.dart`. This allows the API to receive the current NTV (job seeker) user's ID when fetching job listings, enabling personalized job recommendations and user-specific filtering.

## Implementation Details

### 1. **Event Layer Changes** (`lib/blocs/tuyendung/tuyendung_event.dart`)

**Before:**
```dart
const factory TuyenDungEvent.fetchList(String? ntdId) = FetchTuyenDungList;
```

**After:**
```dart
const factory TuyenDungEvent.fetchList(String? ntdId, {String? idUV}) = FetchTuyenDungList;
```

**Benefits:**
- Added optional `idUV` parameter to pass the NTV user ID
- Maintains backward compatibility with existing code
- Allows for user-specific job filtering on the backend

### 2. **Bloc Layer Changes** (`lib/blocs/tuyendung/tuyendung_bloc.dart`)

**Updated the fetch handler:**
```dart
Future<void> _onFetchTuyenDungList(
  FetchTuyenDungList event,
  Emitter<TuyenDungState> emit,
) async {
  emit(TuyenDungLoading());
  try {
    final tuyenDungList = await _repository.getTuyenDungList(event.ntdId, idUV: event.idUV);
    emit(TuyenDungLoaded(tuyenDungList));
  } catch (e) {
    emit(TuyenDungError(e.toString()));
  }
}
```

**Benefits:**
- Passes the `idUV` parameter down to the repository layer
- Maintains existing error handling
- No breaking changes to other event handlers

### 3. **Repository Layer Changes** (`lib/repositories/tuyendung_repository.dart`)

**Updated method signature:**
```dart
Future<List<NTDTuyenDung>> getTuyenDungList(String? ntdId, {String? idUV}) async {
  try {
    final response = await _tuyenDungService.getTuyenDungList(ntdId, idUV: idUV);
    final data = response.data['data'] as List;
    return data.map((json) {
      return NTDTuyenDung.fromJson(json);
    }).toList();
  } on DioException catch (e) {
    throw Exception('Failed to get tuyen dung list: ${e.message}');
  } catch (e) {
    rethrow;
  }
}
```

**Benefits:**
- Forwards the `idUV` parameter to the service layer
- Maintains existing error handling and data parsing
- Optional parameter ensures backward compatibility

### 4. **Service Layer Changes** (`lib/services/tuyendung_service.dart`)

**Enhanced API call with dynamic query parameters:**
```dart
Future<Response> getTuyenDungList(String? ntdId, {String? idUV}) async {
  try {
    // Build query parameters dynamically
    final queryParams = <String, dynamic>{};
    if (ntdId != null) {
      queryParams['idDoanhNghiep'] = ntdId;
    }
    if (idUV != null) {
      queryParams['idUV'] = idUV;
    }

    final response = await _dio.get(
      '/nghiep-vu/tuyendung',
      queryParameters: queryParams,
    );
    return response;
  } on DioException catch (e) {
    throw Exception('Failed to fetch tuyen dung: ${e.message}');
  }
}
```

**Benefits:**
- Dynamic query parameter building
- Only includes parameters that are not null
- Clean API call structure
- Maintains existing error handling

### 5. **UI Layer Changes** (`lib/pages/home/ntv/tim_viec_page.dart`)

**Added user authentication integration:**
```dart
class _TimViecPageState extends State<TimViecPage> {
  // ... existing code ...
  late final AuthBloc _authBloc;
  
  // Current user info
  String? _currentUserId;
  String? _currentUserType;

  void _initializeBlocs() {
    // ... existing bloc initialization ...
    _authBloc = locator<AuthBloc>();
    _getCurrentUserInfo();
  }

  void _getCurrentUserInfo() {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated) {
      _currentUserId = authState.userId;
      _currentUserType = authState.userType;
    }
  }

  void _loadInitialData() {
    // Pass the current user ID (idUV) for NTV users
    if (_currentUserType == 'ntv' && _currentUserId != null) {
      _tuyenDungBloc.add(FetchTuyenDungList(null, idUV: _currentUserId));
    } else {
      // Fallback for other user types
      _tuyenDungBloc.add(FetchTuyenDungList(null));
    }
    // ... rest of initialization ...
  }

  void _performSearch() {
    // Perform search with current user ID for NTV users
    if (_currentUserType == 'ntv' && _currentUserId != null) {
      _tuyenDungBloc.add(FetchTuyenDungList(null, idUV: _currentUserId));
    } else {
      _tuyenDungBloc.add(FetchTuyenDungList(null));
    }
  }
}
```

**Benefits:**
- Automatic user ID detection from authentication state
- User type validation (only for NTV users)
- Graceful fallback for other user types
- Consistent user ID passing across all fetch operations

## API Integration

### **Request Format**

The API endpoint `/nghiep-vu/tuyendung` now receives:

**For NTV users:**
```
GET /nghiep-vu/tuyendung?idUV=123
```

**For NTD users:**
```
GET /nghiep-vu/tuyendung?idDoanhNghiep=456
```

**For both (if needed):**
```
GET /nghiep-vu/tuyendung?idDoanhNghiep=456&idUV=123
```

### **Backend Expectations**

The backend should now be able to:
1. **Receive the `idUV` parameter** in query parameters
2. **Filter job listings** based on the user's profile, preferences, or application history
3. **Return personalized results** for the specific NTV user
4. **Maintain backward compatibility** when `idUV` is not provided

## Features Enabled

### 1. **Personalized Job Recommendations**
- Backend can now filter jobs based on user profile
- Matching algorithm can consider user's skills, experience, location preferences
- Previously applied jobs can be excluded or marked

### 2. **User-Specific Filtering**
- Jobs can be filtered based on user's qualification level
- Location-based filtering using user's preferred work locations
- Salary range filtering based on user's expectations

### 3. **Application History Integration**
- Backend can exclude jobs the user has already applied to
- Show application status for jobs user has interacted with
- Provide "recommended for you" sections

### 4. **Analytics and Tracking**
- Track which jobs specific users view
- Analyze user search patterns
- Improve recommendation algorithms

## Testing Checklist

- [x] **Compilation**: All files compile without errors
- [x] **Backward Compatibility**: Existing NTD functionality still works
- [x] **User Authentication**: Correctly detects NTV users and extracts user ID
- [x] **API Integration**: Properly sends `idUV` parameter in requests
- [x] **Error Handling**: Graceful fallback when user ID is not available
- [x] **Search Functionality**: User ID is included in search requests
- [x] **Filter Application**: User ID is included when filters are applied

## Usage Examples

### **For NTV Users**
```dart
// Automatic - handled by the page
// When an NTV user opens TimViecPage:
// 1. User ID is automatically detected from AuthBloc
// 2. All API calls include idUV parameter
// 3. Backend receives personalized job requests
```

### **For NTD Users**
```dart
// Unchanged behavior
// When an NTD user opens TimViecPage:
// 1. Only idDoanhNghiep parameter is sent (if applicable)
// 2. General job listings are returned
// 3. No user-specific filtering applied
```

## Future Enhancements

### 1. **Real-time Updates**
- WebSocket integration for real-time job notifications
- Push notifications for matching jobs
- Live updates when new jobs are posted

### 2. **Advanced Filtering**
- Server-side search with user context
- Machine learning-based recommendations
- Collaborative filtering based on similar users

### 3. **User Preferences**
- Save user search preferences
- Quick filter presets
- Notification settings for job alerts

### 4. **Application Integration**
- One-click job applications
- Application status tracking
- Interview scheduling integration

## Security Considerations

1. **User ID Validation**: Backend should validate that the `idUV` belongs to an authenticated NTV user
2. **Data Privacy**: Ensure user-specific data is only accessible to the correct user
3. **Rate Limiting**: Implement appropriate rate limiting for personalized requests
4. **Audit Logging**: Log user actions for security and analytics purposes

## Performance Considerations

1. **Caching**: Implement user-specific caching strategies
2. **Database Indexing**: Ensure proper indexing for user-based queries
3. **Pagination**: Maintain efficient pagination with user context
4. **Response Time**: Monitor API response times for personalized requests

This implementation provides a solid foundation for personalized job search functionality while maintaining backward compatibility and following Flutter/Dart best practices.