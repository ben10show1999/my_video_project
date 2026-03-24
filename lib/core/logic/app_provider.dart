import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_strings.dart';

class AppNotification {
  final String title; final String body; final String time; 
  final String? targetId; final String? payload; final String? imageUrl;
  AppNotification({required this.title, required this.body, required this.time, this.targetId, this.payload, this.imageUrl});
}

class AppProvider extends ChangeNotifier {
  int _navIndex = 0; int get navIndex => _navIndex;
  final Set<int> _myListIds = {}; List<int> get myListIds => _myListIds.toList();
  bool _notificationsEnabled = true; bool _isAutoplayEnabled = true; 
  String _preferredQuality = "Auto"; String _languageCode = "auto"; 
  final List<AppNotification> _notifications = [];
  List<int> _cacheTimestamps = [];
  
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isAutoplayEnabled => _isAutoplayEnabled;
  String get preferredQuality => _preferredQuality;
  String get currentLanguageCode => _languageCode;
  
  Locale get locale {
    if (_languageCode == 'auto') return (PlatformDispatcher.instance.locale.languageCode == 'ar') ? const Locale('ar') : const Locale('en');
    return Locale(_languageCode);
  }

  String tr(String key) => AppStrings.get(locale.languageCode, key);
  List<AppNotification> get notifications => _notificationsEnabled ? _notifications : [];

  AppProvider() { _loadPrefs(); }

  void setNavIndex(int index) { _navIndex = index; notifyListeners(); }
  bool isInList(int id) => _myListIds.contains(id);
  void toggleMyList(int id) { if (_myListIds.contains(id)) {
    _myListIds.remove(id);
  } else {
    _myListIds.add(id);
  } notifyListeners(); }
  
  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    _isAutoplayEnabled = prefs.getBool('autoplay_enabled') ?? true;
    _preferredQuality = prefs.getString('pref_quality') ?? "Auto";
    _languageCode = prefs.getString('app_lang') ?? "auto";
    _cacheTimestamps = (prefs.getStringList('cache_clears') ?? []).map((e) => int.tryParse(e) ?? 0).toList();
    _cleanOldCacheTimestamps();
    notifyListeners();
  }

  void _cleanOldCacheTimestamps() { final now = DateTime.now().millisecondsSinceEpoch; final dayMs = 24 * 60 * 60 * 1000; _cacheTimestamps.removeWhere((ts) => now - ts > dayMs); }
  bool get canClearCache { _cleanOldCacheTimestamps(); return _cacheTimestamps.length < 3; }
  int get remainingCacheClears { _cleanOldCacheTimestamps(); return 3 - _cacheTimestamps.length; }

  Future<void> setLanguage(String code) async { _languageCode = code; final prefs = await SharedPreferences.getInstance(); await prefs.setString('app_lang', code); notifyListeners(); }
  Future<void> toggleNotifications(bool value) async { _notificationsEnabled = value; final prefs = await SharedPreferences.getInstance(); await prefs.setBool('notifications_enabled', value); notifyListeners(); }
  Future<void> toggleAutoplay(bool value) async { _isAutoplayEnabled = value; final prefs = await SharedPreferences.getInstance(); await prefs.setBool('autoplay_enabled', value); notifyListeners(); }
  Future<void> setPreferredQuality(String value) async { _preferredQuality = value; final prefs = await SharedPreferences.getInstance(); await prefs.setString('pref_quality', value); notifyListeners(); }
  
  Future<bool> clearCache() async { 
    if (!canClearCache) return false;
    _cacheTimestamps.add(DateTime.now().millisecondsSinceEpoch);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cache_clears', _cacheTimestamps.map((e) => e.toString()).toList());
    await Future.delayed(const Duration(seconds: 1)); 
    PaintingBinding.instance.imageCache.clear(); 
    notifyListeners(); 
    return true;
  }
}
