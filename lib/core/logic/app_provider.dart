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
  // Navigation State for Back Button Logic
  int _navIndex = 0;
  int get navIndex => _navIndex;

  // My List State
  final Set<int> _myListIds = {};
  List<int> get myListIds => _myListIds.toList();

  bool _notificationsEnabled = true; 
  bool _isAutoplayEnabled = true; 
  String _preferredQuality = "Auto"; 
  String _languageCode = "auto"; 

  final List<AppNotification> _notifications = [];
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isAutoplayEnabled => _isAutoplayEnabled;
  String get preferredQuality => _preferredQuality;
  String get currentLanguageCode => _languageCode;
  
  Locale get locale {
    if (_languageCode == 'auto') {
      final systemLoc = PlatformDispatcher.instance.locale.languageCode;
      return (systemLoc == 'ar') ? const Locale('ar') : const Locale('en');
    }
    return Locale(_languageCode);
  }

  String tr(String key) => AppStrings.get(locale.languageCode, key);
  List<AppNotification> get notifications => _notificationsEnabled ? _notifications : [];

  AppProvider() { _loadPrefs(); }

  void setNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }

  bool isInList(int id) => _myListIds.contains(id);
  void toggleMyList(int id) {
    if (_myListIds.contains(id)) {
      _myListIds.remove(id);
    } else {
      _myListIds.add(id);
    }
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    _isAutoplayEnabled = prefs.getBool('autoplay_enabled') ?? true;
    _preferredQuality = prefs.getString('pref_quality') ?? "Auto";
    _languageCode = prefs.getString('app_lang') ?? "auto";
    notifyListeners();
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
  Future<void> clearCache() async { await Future.delayed(const Duration(seconds: 2)); PaintingBinding.instance.imageCache.clear(); notifyListeners(); }
}
