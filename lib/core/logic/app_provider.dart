import 'dart:async';
import 'dart:ui';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/core/services/remote_config_service.dart';
import 'app_strings.dart';

// Task 44: Lifecycle-Aware AppProvider (Zero-Impact Polling)
class AppProvider extends ChangeNotifier with WidgetsBindingObserver {
  int _navIndex = 0; int get navIndex => _navIndex;
  final Set<String> _myListIds = {}; List<String> get myListIds => _myListIds.toList(); 
  
  bool _notificationsEnabled = true; // Task 43: Default Opt-In
  bool _isAutoplayEnabled = true; 
  String _preferredQuality = "Auto"; String _languageCode = "auto"; 
  
  // Tasks 41 & 42: Notification Engine & Blacklist
  final List<AppNotification> _notifications = [];
  final Set<String> _deletedNotificationIds = {};
  Timer? _pollingTimer;
  
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isAutoplayEnabled => _isAutoplayEnabled;
  String get preferredQuality => _preferredQuality;
  String get currentLanguageCode => _languageCode;
  
  List<int> _cacheTimestamps = [];
  
  Locale get locale {
    if (_languageCode == 'auto') {
      final systemLoc = PlatformDispatcher.instance.locale.languageCode;
      const supportedLanguages = ['en', 'ar']; 
      if (supportedLanguages.contains(systemLoc)) { return Locale(systemLoc); }
      return const Locale('en'); 
    }
    return Locale(_languageCode);
  }

  String tr(String key) => AppStrings.get(locale.languageCode, key);
  
  List<AppNotification> get notifications {
    if (_notificationsEnabled) { return _notifications.reversed.toList(); } else { return []; }
  }

  AppProvider() { 
    _loadPrefs(); 
    WidgetsBinding.instance.addObserver(this);
    if (kIsWeb) {
      web.window.addEventListener('visibilitychange', ((web.Event e) {
        if (web.document.hidden) { _stopPolling(); } else { _startPolling(immediateFetch: true); }
      }).toJS);
    }
  }

  // Task 44: Lifecycle Awareness
  @override void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) { _startPolling(immediateFetch: true); } 
    else if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) { _stopPolling(); }
  }

  @override void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopPolling();
    super.dispose();
  }

  void setNavIndex(int index) { _navIndex = index; notifyListeners(); }
  bool isInList(String id) => _myListIds.contains(id);
  void toggleMyList(String id) { 
    if (_myListIds.contains(id)) { _myListIds.remove(id); } else { _myListIds.add(id); }
    _saveMyList(); notifyListeners();
  }
  
  Future<void> _saveMyList() async { final prefs = await SharedPreferences.getInstance(); await prefs.setStringList('my_list', _myListIds.toList()); }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true; 
    _isAutoplayEnabled = prefs.getBool('autoplay_enabled') ?? true;
    _preferredQuality = prefs.getString('pref_quality') ?? "Auto";
    _languageCode = prefs.getString('app_lang') ?? "auto";
    
    final savedList = prefs.getStringList('my_list') ?? [];
    _myListIds.addAll(savedList);

    // Task 42: Load Blacklist
    final deletedList = prefs.getStringList('deleted_notifications') ?? [];
    _deletedNotificationIds.addAll(deletedList);

    final strList = prefs.getStringList('cache_clears') ?? [];
    _cacheTimestamps = strList.map((e) => int.tryParse(e) ?? 0).toList();
    _cleanOldCacheTimestamps();
    
    // Request permission & Start Engine
    if (_notificationsEnabled) {
      _requestWebNotificationPermission();
      _syncNotifications(); 
      _startPolling(); 
    }
    notifyListeners();
  }

  // Task 44 & 42: The 60s Heartbeat Engine
  void _startPolling({bool immediateFetch = false}) {
    if (!_notificationsEnabled) return; 
    _pollingTimer?.cancel();
    if (immediateFetch) { _triggerSilentFetch(); }
    _pollingTimer = Timer.periodic(const Duration(seconds: 60), (_) => _triggerSilentFetch());
  }

  void _stopPolling() { _pollingTimer?.cancel(); }

  void _triggerSilentFetch() async {
    await RemoteConfigService.fetchConfig();
    _syncNotifications();
  }

  // Task 41 & 42: Smart Diffing & Blacklist Enforcement
  void _syncNotifications() {
    if (!_notificationsEnabled) return;
    bool hasNew = false;
    
    // Execute diffing in Microtask to ensure Zero-Jank
    scheduleMicrotask(() {
      final existingIds = _notifications.map((e) => e.id).toSet();
      for (var cloudNote in RemoteConfigService.cloudNotifications) {
        if (!_deletedNotificationIds.contains(cloudNote.id) && !existingIds.contains(cloudNote.id)) {
          _notifications.add(cloudNote);
          hasNew = true;
          _triggerOSNotification(cloudNote);
        }
      }
      if (hasNew) { notifyListeners(); }
    });
  }

  // Task 41: OS Push Logic (Zero external packages dependency constraint)
  void _requestWebNotificationPermission() {
    if (kIsWeb) {
      try {
         if (web.Notification.permission != 'granted' && web.Notification.permission != 'denied') {
            web.Notification.requestPermission().toDart;
         }
      } catch (_) {}
    }
  }

  void _triggerOSNotification(AppNotification note) {
    if (kIsWeb) {
      try {
        if (web.Notification.permission == 'granted') {
          web.Notification(note.title, web.NotificationOptions(body: note.body, icon: note.imageUrl ?? RemoteConfigService.appLogoUrl ?? ""));
        }
      } catch (_) {}
    }
    // On Mobile/Desktop without external packages, we rely on the internal badge or custom toast which can be added to the global context if needed.
  }

  // Task 42: Delete Notification (Add to Blacklist)
  Future<void> deleteNotification(String id) async {
    _notifications.removeWhere((n) => n.id == id);
    _deletedNotificationIds.add(id);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('deleted_notifications', _deletedNotificationIds.toList());
  }

  void _cleanOldCacheTimestamps() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final dayMs = 24 * 60 * 60 * 1000;
    _cacheTimestamps.removeWhere((ts) => now - ts > dayMs);
  }

  bool get canClearCache { _cleanOldCacheTimestamps(); return _cacheTimestamps.length < 3; }
  int get remainingCacheClears { _cleanOldCacheTimestamps(); return 3 - _cacheTimestamps.length; }

  Future<void> setLanguage(String code) async { _languageCode = code; final prefs = await SharedPreferences.getInstance(); await prefs.setString('app_lang', code); notifyListeners(); }
  
  // Task 43: Toggle controls the Polling Engine
  Future<void> toggleNotifications(bool value) async { 
    _notificationsEnabled = value; 
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setBool('notifications_enabled', value); 
    if (value) { _requestWebNotificationPermission(); _startPolling(immediateFetch: true); } else { _stopPolling(); }
    notifyListeners(); 
  }
  
  Future<void> toggleAutoplay(bool value) async { _isAutoplayEnabled = value; final prefs = await SharedPreferences.getInstance(); await prefs.setBool('autoplay_enabled', value); notifyListeners(); }
  Future<void> setPreferredQuality(String value) async { _preferredQuality = value; final prefs = await SharedPreferences.getInstance(); await prefs.setString('pref_quality', value); notifyListeners(); }
  
  Future<bool> clearCache() async { 
    if (!canClearCache) return false;
    _cacheTimestamps.add(DateTime.now().millisecondsSinceEpoch);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cache_clears', _cacheTimestamps.map((e) => e.toString()).toList());
    
    await Future.delayed(const Duration(seconds: 2)); 
    PaintingBinding.instance.imageCache.clear(); 
    notifyListeners(); 
    return true;
  }
}
