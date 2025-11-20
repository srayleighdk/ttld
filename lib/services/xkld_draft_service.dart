import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';

/// Service for managing XKLD form drafts with auto-save functionality
class XKLDDraftService {
  static const String _draftKey = 'xkld_draft';
  static const String _lastSavedKey = 'xkld_draft_last_saved';
  static const Duration _autoSaveDuration = Duration(seconds: 30);

  Timer? _autoSaveTimer;
  HosoXKLDModel? _currentDraft;
  Function(DateTime)? _onSaved;

  /// Start auto-save timer
  void startAutoSave(
    HosoXKLDModel initialData,
    Function() getCurrentData,
    Function(DateTime) onSaved,
  ) {
    _currentDraft = initialData;
    _onSaved = onSaved;

    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(_autoSaveDuration, (timer) async {
      final data = getCurrentData();
      await saveDraft(data);
      _onSaved?.call(DateTime.now());
    });
  }

  /// Stop auto-save timer
  void stopAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = null;
  }

  /// Save draft to local storage
  Future<void> saveDraft(HosoXKLDModel data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data.toJson());
      await prefs.setString(_draftKey, jsonString);
      await prefs.setString(
        _lastSavedKey,
        DateTime.now().toIso8601String(),
      );
      _currentDraft = data;
    } catch (e) {
      print('Error saving draft: $e');
    }
  }

  /// Load draft from local storage
  Future<HosoXKLDModel?> loadDraft() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_draftKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString);
        return HosoXKLDModel.fromJson(json);
      }
    } catch (e) {
      print('Error loading draft: $e');
    }
    return null;
  }

  /// Get last saved timestamp
  Future<DateTime?> getLastSavedTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timeString = prefs.getString(_lastSavedKey);
      if (timeString != null) {
        return DateTime.parse(timeString);
      }
    } catch (e) {
      print('Error getting last saved time: $e');
    }
    return null;
  }

  /// Check if draft exists
  Future<bool> hasDraft() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_draftKey);
  }

  /// Clear draft
  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
    await prefs.remove(_lastSavedKey);
    _currentDraft = null;
  }

  /// Dispose resources
  void dispose() {
    stopAutoSave();
  }
}
