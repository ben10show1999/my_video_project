import 'dart:ui';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as web;

import 'app_strings.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/core/services/remote_config_service.dart';

class AppProvider extends ChangeNotifier {
  int _navIndex = 0; 
  int get navIndex => _navIndex;
  
  final Set<String> _myListIds = {}; 
  List<String> get myListIds => _myListIds.toList(); 
  
  bool _notificationsEnabled = true; 
  bool _isAutoplayEnabled = true; 
  String _preferredQuality = "Auto"; 
  String _languageCode = "auto"; 
  
  // Task 40: Local Blacklist for Notifications
  final Set<String> _deletedNotifIds = {};
  final Set<String> _seenNotifIds = {};
  
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isAutoplayEnabled => _isAutoplayEnabled;
  String get preferredQuality => _preferredQuality;
  String get currentLanguageCode => _languageCode;
  
  List<int> _cacheTimestamps = [];
  bool _isFetchingGist = false;

  Locale get locale {
    if (_languageCode == 'auto') {
      final systemLoc = PlatformDispatcher.instance.locale.languageCode;
      const supportedLanguages = ['en', 'ar']; 
      if (supportedLanguages.contains(systemLoc)) { 
        return Locale(systemLoc); 
      }
      return const Locale('en'); 
    }
    return Locale(_languageCode);
  }

  String tr(String key) => AppStrings.get(locale.languageCode, key);
  
  // Task 38: Filter out deleted notifications
  List<AppNotificationModel> get activeNotifications {
    if (!_notificationsEnabled) return [];
    return RemoteConfigService.notifications.where((n) => !_deletedNotifIds.contains(n.id)).toList();
  }

  AppProvider() { 
    _loadPrefs(); 
    _initServerlessPushEngine(); 
  }

  void setNavIndex(int index) { 
    _navIndex = index; 
    notifyListeners(); 
  }
  
  bool isInList(String id) => _myListIds.contains(id);
  
  void toggleMyList(String id) { 
    if (_myListIds.contains(id)) { 
      _myListIds.remove(id); 
    } else { 
      _myListIds.add(id); 
    }
    _saveMyList(); 
    notifyListeners();
  }
  
  // Task 40: Delete Notification Local Logic
  Future<void> deleteNotification(String id) async {
    _deletedNotifIds.add(id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('deleted_notifs', _deletedNotifIds.toList());
    notifyListeners();
  }

  Future<void> _saveMyList() async { 
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setStringList('my_list', _myListIds.toList()); 
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    _isAutoplayEnabled = prefs.getBool('autoplay_enabled') ?? true;
    _preferredQuality = prefs.getString('pref_quality') ?? "Auto";
    _languageCode = prefs.getString('app_lang') ?? "auto";
    
    _myListIds.addAll(prefs.getStringList('my_list') ?? []);
    _deletedNotifIds.addAll(prefs.getStringList('deleted_notifs') ?? []);
    _seenNotifIds.addAll(prefs.getStringList('seen_notifs') ?? []);

    final strList = prefs.getStringList('cache_clears') ?? [];
    _cacheTimestamps = strList.map((e) => int.tryParse(e) ?? 0).toList();
    _cleanOldCacheTimestamps();
    notifyListeners();
    
    if (_notificationsEnabled && kIsWeb) { 
      try { 
        web.Notification.requestPermission(); 
      } catch(e) { debugPrint('Notification init error: $e'); } 
    }
  }

  // Tasks 39 & 41: ntfy Wake-up Ping & Visibility API Re-sync
  void _initServerlessPushEngine() {
    if (!kIsWeb) return;
    try {
      // 1. Native JS EventSource for ntfy
      final es = web.EventSource('https://ntfy.sh/v9_secret_trigger_topic/sse');
      es.addEventListener('message', (web.Event e) { 
        _triggerSmartSync(); 
      }.toJS);
    } catch(e) { 
      debugPrint("SSE Error: $e"); 
    }

    try {
      // 2. Visibility API to bypass WebView freeze states
      web.document.addEventListener('visibilitychange', (web.Event e) {
        if (web.document.visibilityState == 'visible') { 
          _triggerSmartSync(); 
        }
      }.toJS);
    } catch(e) { 
      debugPrint("Vis Error: $e"); 
    }
  }

  // Debounced Gist Fetcher
  void _triggerSmartSync() async {
    if (_isFetchingGist || !_notificationsEnabled) return;
    _isFetchingGist = true;
    
    bool updated = await RemoteConfigService.fetchConfig(forceRefresh: true);
    if (updated) { 
      _processNewNotifications(); 
      notifyListeners(); 
    }
    
    // 10-second debounce protection
    Future.delayed(const Duration(seconds: 10), () => _isFetchingGist = false);
  }

  void _processNewNotifications() async {
    if (!_notificationsEnabled) return;
    bool hasNew = false;
    
    for (var n in RemoteConfigService.notifications) {
      if (!_seenNotifIds.contains(n.id) && !_deletedNotifIds.contains(n.id)) {
        _seenNotifIds.add(n.id);
        hasNew = true;
        _showSystemNotification(n);
      }
    }
    
    if (hasNew) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('seen_notifs', _seenNotifIds.toList());
    }
  }

  // Tasks 39: Local System Push Construction
  void _showSystemNotification(AppNotificationModel n) {
    if (!kIsWeb) return;
    try {
      if (web.Notification.permission == 'granted') {
        final options = web.NotificationOptions(body: n.body, icon: n.imageUrl ?? '');
        final notif = web.Notification(n.title, options);
        notif.onclick = (web.Event e) { 
          web.window.focus(); 
        }.toJS;
      }
    } catch (_) {}
  }

  void _cleanOldCacheTimestamps() { 
    final now = DateTime.now().millisecondsSinceEpoch; 
    const dayMs = 24 * 60 * 60 * 1000; 
    _cacheTimestamps.removeWhere((ts) => now - ts > dayMs); 
  }
  
  bool get canClearCache { 
    _cleanOldCacheTimestamps(); 
    return _cacheTimestamps.length < 3; 
  }
  
  int get remainingCacheClears { 
    _cleanOldCacheTimestamps(); 
    return 3 - _cacheTimestamps.length; 
  }

  Future<void> setLanguage(String code) async { 
    _languageCode = code; 
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setString('app_lang', code); 
    notifyListeners(); 
  }
  
  Future<void> toggleNotifications(bool value) async { 
    _notificationsEnabled = value; 
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setBool('notifications_enabled', value); 
    notifyListeners(); 
  }
  
  Future<void> toggleAutoplay(bool value) async { 
    _isAutoplayEnabled = value; 
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setBool('autoplay_enabled', value); 
    notifyListeners(); 
  }
  
  Future<void> setPreferredQuality(String value) async { 
    _preferredQuality = value; 
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setString('pref_quality', value); 
    notifyListeners(); 
  }
  
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
